package com.github.fruna97.nadeuri.security;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import com.github.fruna97.nadeuri.domain.Member;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
class SecurityIntegrationTest {

    @Autowired
    private MockMvc mockMvc;
    @MockitoBean
    private UserDetailsService userDetailsService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Test
    void 로그인_성공시_JWT_반환() throws Exception {
        String testEmail = "test_email@test.com";
        String testPassword = "test_password";

        PrincipalDetails principalDetails = new PrincipalDetails(Member.builder().email(testEmail)
                .password(passwordEncoder.encode(testPassword)).build());
        when(userDetailsService.loadUserByUsername(testEmail)).thenReturn(principalDetails);

        ResultActions result = mockMvc
                .perform(post("/member/signin").contentType(MediaType.APPLICATION_JSON).content("""
                        {
                                "email": "%s",
                                "password": "%s"
                        }
                        """.formatted(testEmail, testPassword)));

        result.andExpectAll(status().isOk(), header().exists(HttpHeaders.AUTHORIZATION));
    }

    @Test
    void 유효하지_않은_정보로_로그인시_401_반환() throws Exception {
        String testEmail = "test_email@test.com";
        String testPassword = "test_password";
        String wrongPassword = "wrong_password";

        PrincipalDetails principalDetails = new PrincipalDetails(Member.builder().email(testEmail)
                .password(passwordEncoder.encode(testPassword)).build());
        when(userDetailsService.loadUserByUsername(testEmail)).thenReturn(principalDetails);

        ResultActions result = mockMvc
                .perform(post("/member/signin").contentType(MediaType.APPLICATION_JSON).content("""
                        {
                                "email": "%s",
                                "password": "%s"
                        }
                        """.formatted(testEmail, wrongPassword)));
        result.andExpectAll(status().isUnauthorized(),
                header().doesNotExist(HttpHeaders.AUTHORIZATION));
    }
}
