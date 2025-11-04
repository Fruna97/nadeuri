package com.github.fruna97.nadeuri.domain.auth.controller;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
class AuthControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;
    @MockitoBean
    private UserDetailsService userDetailsService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Test
    void signIn() throws Exception {
        // Given
        String testEmail = "test_email@test.com";
        String testPassword = "test_password";

        PrincipalDetails principalDetails = new PrincipalDetails(Member.builder()
                .uuid(UUID.randomUUID())
                .email(testEmail)
                .password(passwordEncoder.encode(testPassword))
                .build());
        when(userDetailsService.loadUserByUsername(testEmail)).thenReturn(principalDetails);

        // When
        ResultActions result = mockMvc
                .perform(post("/auth/signin").contentType(MediaType.APPLICATION_JSON).content("""
                        {
                                "email": "%s",
                                "password": "%s"
                        }
                        """.formatted(testEmail, testPassword)));

        // Then
        result.andExpectAll(status().isOk() // 200 OK를 반환하는지
                , jsonPath("$.data.accessToken").exists() // JSON 키 [accessToken]를 포함하고 있는지
                , jsonPath("$.data.refreshToken").exists()); // JSON 키 [refreshToken]를 포함하고 있는지
    }

    @Test
    void signInWithWrongCredentials() throws Exception {
        // Given
        String testEmail = "test_email@test.com";
        String testPassword = "test_password";
        String wrongPassword = "wrong_password";

        PrincipalDetails principalDetails = new PrincipalDetails(Member.builder()
                .uuid(UUID.randomUUID())
                .email(testEmail)
                .password(passwordEncoder.encode(testPassword))
                .build());
        when(userDetailsService.loadUserByUsername(testEmail)).thenReturn(principalDetails);

        // When
        ResultActions result = mockMvc
                .perform(post("/auth/signin").contentType(MediaType.APPLICATION_JSON).content("""
                        {
                                "email": "%s",
                                "password": "%s"
                        }
                        """.formatted(testEmail, wrongPassword)));

        // Then
        result.andExpect(status().isUnauthorized()); // 401 Unauthorized를 반환하는지
    }
}
