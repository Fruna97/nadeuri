package com.github.fruna97.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import java.util.Map;
import java.util.UUID;
import org.assertj.core.api.ThrowableAssert.ThrowingCallable;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;
import com.github.fruna97.nadeuri.repository.MemoryMemberRepository;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@ExtendWith(MockitoExtension.class)
class MemberServiceImplTest {

    @Mock PrincipalDetails principalDetails;
    @Mock Authentication authentication;

    BCryptPasswordEncoder bCryptPasswordEncoder;
    @Mock AuthenticationManager authenticationManager;
    MemoryMemberRepository memberRepository;
    @Mock JwtService jwtService;
    MemberService memberService;

    @BeforeEach
    void beforeEach() {
        bCryptPasswordEncoder = new BCryptPasswordEncoder();
        memberRepository = new MemoryMemberRepository();
        memberService = new MemberServiceImpl(bCryptPasswordEncoder, authenticationManager, memberRepository, jwtService);
    }

    @AfterEach
    void afterEach() {
        if (memberRepository instanceof MemoryMemberRepository) {
            MemoryMemberRepository.clear();
        }
    }

    @Test
    void signUp_성공() {
        // Given
        String email = "test_email@test.com";
        String password = "test_password";
        String nickname = "test_nickname";

        // When
        Member savedMember = memberService.signUp(email, password, nickname);
        Member result = memberRepository.findById(savedMember.getId()).get();

        // Then
        assertThat(result).isEqualTo(savedMember);
    }

    @Test
    void signUp_중복이메일() {
        // Given
        String email1 = "test_email@test.com";
        String password1 = "test_password_1";
        String nickname1 = "test_nickname_1";

        String email2 = "test_email@test.com";
        String password2 = "test_password_2";
        String nickname2 = "test_nickname_2";

        // When
        memberService.signUp(email1, password1, nickname1);
        ThrowingCallable signUpWithDuplicatedEmailAction = () -> memberService.signUp(email2, password2, nickname2);

        // Then
        assertThatThrownBy(signUpWithDuplicatedEmailAction)
                .isInstanceOf(DuplicateEmailException.class);
    }

    @Test
    void signIn_성공() {
        // given
        String email = "test_email@test.com";
        String password = "test_password";

        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class))).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(principalDetails);
        when(principalDetails.getUuid()).thenReturn(UUID.randomUUID());
        when(jwtService.createAccessToken(any(UUID.class))).thenReturn("test_access_token");
        when(jwtService.createAndSaveRefreshToken(any(UUID.class))).thenReturn("test_refreshToken_token");

        // when
        Map<String, String> result = memberService.signIn(email, password);

        // then
        assertThat(result).containsKeys("accessToken", "refreshToken");
    }

    @Test
    void signIn_유효하지않은회원() {
        // given
        String email = "test_email@test.com";
        String password = "test_password";

        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class))).thenThrow(new BadCredentialsException("자격 증명에 실패하였습니다."));

        // when
        ThrowingCallable signInWithInvalidCredentials = () -> memberService.signIn(email, password);

        // then
        assertThatThrownBy(signInWithInvalidCredentials).isInstanceOf(AuthenticationException.class);
    }
}
