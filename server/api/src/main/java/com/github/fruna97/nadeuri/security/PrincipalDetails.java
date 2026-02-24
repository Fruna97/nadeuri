package com.github.fruna97.nadeuri.security;

import java.util.Collection;
import java.util.UUID;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class PrincipalDetails implements UserDetails {

    private final UUID uuid;
    private final String email;
    private final String password;
    
    private PrincipalDetails(UUID uuid, String email, String password) {
        this.uuid = uuid;
        this.email = email;
        this.password = password;
    }

    public static PrincipalDetails ofSignIn(UUID uuid, String email, String password) {
        return new PrincipalDetails(uuid, email, password);
    }

    public static PrincipalDetails ofJwt(UUID uuid) {
        return new PrincipalDetails(uuid, null, null);
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public UUID getUuid() {
        return uuid;
    }
}
