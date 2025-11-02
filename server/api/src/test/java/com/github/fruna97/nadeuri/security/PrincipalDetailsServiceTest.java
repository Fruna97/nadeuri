package com.github.fruna97.nadeuri.security;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.when;
import java.util.Optional;
import java.util.UUID;
import org.assertj.core.api.ThrowableAssert.ThrowingCallable;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;

@ExtendWith(MockitoExtension.class)
class PrincipalDetailsServiceTest {

    @Mock
    private MemberRepository memberRepository;

    @InjectMocks
    private PrincipalDetailsService principalDetailsService;

    @Test
    void loadUserByUsername_회원존재() {
        // Given
        UUID uuid = UUID.randomUUID();
        String email = "test_email@test.com";
        String password = "test_email@test.com";
        String nickname = "test_email@test.com";
        Member member = Member.builder().uuid(uuid).email(email).password(password).nickname(nickname).build();

        when(memberRepository.findByEmail(email)).thenReturn(Optional.of(member));

        // When
        PrincipalDetails principalDetails =
                (PrincipalDetails) principalDetailsService.loadUserByUsername(email);

        // Then
        assertThat(principalDetails.getUsername()).isEqualTo(email);
        assertThat(principalDetails.getNickname()).isEqualTo(nickname);
    }

    @Test
    void loadUserByUsername_회원없음() {
        // Given
        String email = "test_email@test.com";
        when(memberRepository.findByEmail(email)).thenReturn(Optional.empty());

        // When
        ThrowingCallable loadNoSuchEmail = () -> principalDetailsService.loadUserByUsername(email);

        // Then
        assertThatThrownBy(loadNoSuchEmail)
                .isInstanceOf(UsernameNotFoundException.class)
                .hasMessageContaining("존재하지 않는 회원 입니다: " + email);
    }
}
