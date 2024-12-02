package org.iesbelen.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.iesbelen.dao.*;
import org.iesbelen.model.Fabricante;
import org.iesbelen.model.Usuario;
import org.iesbelen.utilities.Utility;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@WebServlet(name = "UsuariosServlet", value = "/tienda/usuarios/*")
public class UsuariosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * HTTP Method: GET
     * Paths:
     * /usuarios/
     * /usuarios/{id}
     * /usuarios/editar{id}
     * /usuarios/crear
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher;
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || "/".equals(pathInfo)) {
            UsuarioDAO UserDAO = new UsuarioDAOImpl();

            //GET
            //	/usuarios/
            //	/usuarios

            request.setAttribute("listaUsuarios", UserDAO.getAll());
            dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/usuarios.jsp");

        } else {
            // GET
            //      /usuarios/{id}
            //      /usuarios/{id}/
            //      /usuarios/edit{id}
            //      /usuarios/edit{id}/
            //      /usuarios/crear
            //      /usuarios/crear/
            pathInfo = pathInfo.replaceAll("/$", "");
            String[] pathParts = pathInfo.split("/");
            if (pathParts.length == 2 && "login".equals(pathParts[1])) {
                // GET /usuarios/login
                dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/login.jsp");
            } else if (pathParts.length == 2 && "crear".equals(pathParts[1])) {
                // /usuarios/crear
                dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/crear-usuario.jsp");

            } else if (pathParts.length == 2) {
                UsuarioDAO userDAO = new UsuarioDAOImpl();
                // GET
                // /usuarios/{id}
                try {
                    request.setAttribute("usuario", userDAO.find(Integer.parseInt(pathParts[1])));
                    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/detalle-usuario.jsp");

                } catch (NumberFormatException nfe) {
                    nfe.printStackTrace();
                    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/usuarios.jsp");
                }
            } else if (pathParts.length == 3 && "editar".equals(pathParts[1])) {
                UsuarioDAO userDAO = new UsuarioDAOImpl();

                // GET
                // /usuarios/editar/{id}
                try {
                    request.setAttribute("usuario", userDAO.find(Integer.parseInt(pathParts[2])));
                    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/editar-usuario.jsp");

                } catch (NumberFormatException nfe) {
                    nfe.printStackTrace();
                    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/usuarios.jsp");
                }

            } else {

                System.out.println("Opción POST no soportada.");
                dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/usuarios.jsp");

            }

        }

        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        String __method__ = request.getParameter("__method__");
        UsuarioDAO userDAO = new UsuarioDAOImpl();

        if ("/login".equals(pathInfo)) {
            // Manejo del login
            doLogin(request, response, userDAO);
            return;
        } else if ("/logout".equals(pathInfo)) {
            // Manejo del logout
            doLogout(request, response);
            return;
        } else if (__method__ == null) {
            // Crear un nuevo usuario
            String usuario = request.getParameter("usuario");
            String password = request.getParameter("password");
            String rol = request.getParameter("rol");

            Usuario nuevoUsuario = new Usuario();
            nuevoUsuario.setUsuario(usuario);
            try {
                nuevoUsuario.setPassword(Utility.hashPassword(password)); // Asegúrate de aplicar hashing aquí
            } catch (NoSuchAlgorithmException e) {
                throw new RuntimeException(e);
            }
            nuevoUsuario.setRol(rol);
            userDAO.create(nuevoUsuario);
        } else if ("put".equalsIgnoreCase(__method__)) {
            // Actualizar un usuario existente
            doPut(request, response);

        } else if ("delete".equalsIgnoreCase(__method__)) {
            // Eliminar un usuario
            doDelete(request, response);

        } else {
            System.out.println("Operación POST no soportada.");
        }

        response.sendRedirect(request.getContextPath() + "/tienda/usuarios");
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UsuarioDAO userDAO = new UsuarioDAOImpl();

        try {
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            String usuario = request.getParameter("usuario");
            String password = request.getParameter("password");
            String rol = request.getParameter("rol");

            Usuario user = new Usuario();
            user.setIdUsuario(idUsuario);
            user.setUsuario(usuario);
            user.setPassword(Utility.hashPassword(password)); // Asegúrate de aplicar hashing aquí
            user.setRol(rol);
            userDAO.update(user);

        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher dispatcher;
        UsuarioDAO userDAO = new UsuarioDAOImpl();
        String codigo = request.getParameter("codigo");

        try {
            int idUsuario = Integer.parseInt(codigo);
            userDAO.delete(idUsuario);

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    private void doLogin(HttpServletRequest request, HttpServletResponse response, UsuarioDAO userDAO) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        Usuario user = userDAO.findByCredentials(usuario, password);
        try {
            if (user != null && Utility.hashPassword(password).equals(user.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario-logado", user);
                response.sendRedirect(request.getContextPath() + "/");
            } else {
                request.setAttribute("error", "Usuario o contraseña incorrectos.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/login.jsp");
                dispatcher.forward(request, response);
            }

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en el sistema");
        }
    }

    private void doLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/");
    }

}


