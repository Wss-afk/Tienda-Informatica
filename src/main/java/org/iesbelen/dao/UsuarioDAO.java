package org.iesbelen.dao;

import org.iesbelen.model.Usuario;

import java.util.List;
import java.util.Optional;

public interface UsuarioDAO {
    public void create(Usuario usuario);

    public Optional<Usuario> find(int idUsuario);

    public List<Usuario> getAll();

    public void update(Usuario usuario);

    public void delete(int idUsuario);

    Usuario findByCredentials(String usuario, String password);




}
