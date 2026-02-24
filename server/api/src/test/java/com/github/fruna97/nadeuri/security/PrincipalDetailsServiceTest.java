package com.github.fruna97.nadeuri.security;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.when;
import java.util.Optional;
import java.util.UUID;
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
    void loadUserByUsername() {
        // Given
        long id = 0L;
        UUID uuid = UUID.randomUUID();
        String email = "test_email@test.com";
        String password = "test_email@test.com";
        String nickname = "test_email@test.com";
        Member member = Member.builder().id(id).uuid(uuid).email(email).password(password).nickname(nickname).build();

        when(memberRepository.findByEmail(email)).thenReturn(Optional.of(member));

        // When
        PrincipalDetails result =
                (PrincipalDetails) principalDetailsService.loadUserByUsername(email);

        // Then
        assertAll(
                () -> assertThat(result.getUsername()).isEqualTo(email),
                () -> assertThat(result.getPassword()).isEqualTo(password),
                () -> assertThat(result.getId()).isEqualTo(id),
                () -> assertThat(result.getUuid()).isEqualTo(uuid)); // 불러온 회원 정보가 저장된 회원 정보와 같은지
    }

    @Test
    void loadUserByUsername_없는회원() {
        // Given
        String email = "test_email@test.com";
        when(memberRepository.findByEmail(email)).thenReturn(Optional.empty());

        // When
        // Then
        assertThrows(UsernameNotFoundException.class,
                () -> principalDetailsService.loadUserByUsername(email)); // 존재하지 않는 회원에 대해서 UsernameNotFoundException 예외를 발생시키는지
    }
}
