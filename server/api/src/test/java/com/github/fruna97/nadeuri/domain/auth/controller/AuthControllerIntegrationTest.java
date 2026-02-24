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
        UUID uuid = UUID.randomUUID();
        String email = "test_email@test.com";
        String password = "test_password";
        String encodedPassword = passwordEncoder.encode(password);

        PrincipalDetails principalDetails = PrincipalDetails.ofSignIn(uuid, email, encodedPassword);
        when(userDetailsService.loadUserByUsername(email)).thenReturn(principalDetails);

        // When
        ResultActions result = mockMvc
                .perform(post("/auth/signin").contentType(MediaType.APPLICATION_JSON).content("""
                        {
                                "email": "%s",
                                "password": "%s"
                        }
                        """.formatted(email, password)));

        // Then
        result.andExpectAll(status().isOk() // 200 OK를 반환하는지
                , jsonPath("$.data.accessToken").exists() // JSON 키 [accessToken]를 포함하고 있는지
                , jsonPath("$.data.refreshToken").exists()); // JSON 키 [refreshToken]를 포함하고 있는지
    }

    @Test
    void signInWithWrongCredentials() throws Exception {
        // Given
        UUID uuid = UUID.randomUUID();
        String email = "test_email@test.com";
        String password = "test_password";
        String encodedPassword = passwordEncoder.encode(password);

        PrincipalDetails principalDetails = PrincipalDetails.ofSignIn(uuid, email, encodedPassword);
        when(userDetailsService.loadUserByUsername(email)).thenReturn(principalDetails);

        // When
        String wrongPassword = "wrong_password";
        ResultActions result = mockMvc
                .perform(post("/auth/signin").contentType(MediaType.APPLICATION_JSON).content("""
                        {
                                "email": "%s",
                                "password": "%s"
                        }
                        """.formatted(email, wrongPassword)));

        // Then
        result.andExpect(status().isUnauthorized()); // 401 Unauthorized를 반환하는지
    }
}
