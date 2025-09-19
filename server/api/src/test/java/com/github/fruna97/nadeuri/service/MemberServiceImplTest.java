package com.github.fruna97.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.Map;
import java.util.UUID;
import org.assertj.core.api.ThrowableAssert.ThrowingCallable;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;
import com.github.fruna97.nadeuri.repository.MemberRepository;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@ExtendWith(MockitoExtension.class)
class MemberServiceImplTest {

    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Mock
    PrincipalDetails principalDetails;

    @Mock
    Authentication authentication;

    @Mock
    AuthenticationManager authenticationManager;

    @Mock
    MemberRepository memberRepository;

    @Mock
    JwtService jwtService;

    MemberService memberService;

    @Captor
    ArgumentCaptor<Member> memberCaptor;

    @BeforeEach
    void beforeEach() {
        bCryptPasswordEncoder = new BCryptPasswordEncoder();
        memberService = new MemberServiceImpl(bCryptPasswordEncoder, authenticationManager, memberRepository, jwtService);
    }

    @Test
    void signUp() {
        // Given
        UUID uuid = UUID.randomUUID();
        String email = "test_email@test.com";
        String password = "test_password";
        String nickname = "test_nickname";
        Member savedMember = Member.builder().uuid(uuid).email(email).password(password).nickname(nickname).build();
        when(memberRepository.saveAndFlush(any(Member.class))).thenReturn(savedMember);

        // When
        Member result = memberService.signUp(email, password, nickname);

        // Then
        assertThat(result).isEqualTo(savedMember); // 저장된 객체를 그대로 반환 하는지

        verify(memberRepository).saveAndFlush(memberCaptor.capture());
        Member capturedMember = memberCaptor.getValue();
        String encodedPassword = capturedMember.getPassword();
        assertTrue(bCryptPasswordEncoder.matches(password, encodedPassword)); // 비밀번호를 암호화 하여 저장 하는지
    }

    @Test
    void signUp_중복이메일() {
        // Given
        String email = "test_email@test.com";
        String password = "test_password";
        String nickname = "test_nickname";
        when(memberRepository.saveAndFlush(any(Member.class))).thenThrow(DataIntegrityViolationException.class);

        // When
        ThrowingCallable signUpWithDuplicatedEmailAction = () -> memberService.signUp(email, password, nickname);

        // Then
        assertThatThrownBy(signUpWithDuplicatedEmailAction)
                .isInstanceOf(DuplicateEmailException.class); // DuplicateEmailException을 re-throw 하는지
    }

    @Test
    void signIn() {
        // Given
        String email = "test_email@test.com";
        String password = "test_password";

        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class))).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(principalDetails);
        when(principalDetails.getUuid()).thenReturn(UUID.randomUUID());
        when(jwtService.createAccessToken(any(UUID.class))).thenReturn("test_access_token");
        when(jwtService.createAndSaveRefreshToken(any(UUID.class))).thenReturn("test_refreshToken_token");

        // When
        Map<String, String> result = memberService.signIn(email, password);

        // Then
        assertThat(result).containsKeys("accessToken", "refreshToken"); // accessToken과 refreshToken을 담고 있는지
    }

    @Test
    void signIn_유효하지않은회원() {
        // Given
        String email = "test_email@test.com";
        String password = "test_password";

        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class))).thenThrow(new BadCredentialsException("자격 증명에 실패하였습니다."));

        // When
        ThrowingCallable signInWithInvalidCredentials = () -> memberService.signIn(email, password);

        // Then
        assertThatThrownBy(signInWithInvalidCredentials).isInstanceOf(AuthenticationException.class); // 인증 예외를 throw 하는지
    }
}
