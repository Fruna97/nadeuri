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
import com.github.fruna97.nadeuri.dto.SignUpDto;
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
    void signUp() {
        // Given
        SignUpDto signUpDto = SignUpDto.builder()
                .email("test_email@test.com")
                .password("test_password")
                .nickname("test_nickname")
                .build();

        // When
        Member savedMember = memberService.signUp(signUpDto);
        Member result = memberRepository.findById(savedMember.getId()).get();

        // Then
        assertThat(result).isEqualTo(savedMember);
    }

    @Test
    void signUpWithDuplicateEmail() {
        // Given
        SignUpDto signUpDto1 = SignUpDto.builder()
                .email("test_email_1@test.com")
                .password("test_password")
                .nickname("test_nickname")
                .build();

        SignUpDto signUpDto2 = SignUpDto.builder()
                .email("test_email_1@test.com")
                .password("test_password")
                .nickname("test_nickname")
                .build();

        // When
        memberService.signUp(signUpDto1);
        ThrowingCallable signUpWithDuplicatedEmailAction = () -> memberService.signUp(signUpDto2);

        // Then
        assertThatThrownBy(signUpWithDuplicatedEmailAction)
                .isInstanceOf(DuplicateEmailException.class)
                .hasMessageContaining("이미 존재하는 이메일 입니다: " + signUpDto2.getEmail());
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
