package com.mytoken.controller;

import java.io.IOException;
import java.util.List;

import com.mytoken.dao.UserDAO;
import com.mytoken.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class UserServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp")
                       .forward(request, response);
                break;
            case "edit":
                int userId = Integer.parseInt(request.getParameter("id"));
                User user = userDAO.getUserById(userId);
                request.setAttribute("editUser", user);
                request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp")
                       .forward(request, response);
                break;
            case "toggle":
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                userDAO.updateStatus(id, status);
                response.sendRedirect(request.getContextPath() + "/admin/user");
                break;
            default:
                List<User> users = userDAO.getAllUsers();
                request.setAttribute("users", users);
                request.getRequestDispatcher("/WEB-INF/views/admin/user-list.jsp")
                       .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pin = request.getParameter("pin");
        String role = request.getParameter("role");
        String department = request.getParameter("department");
        String designation = request.getParameter("designation");
        String status = request.getParameter("status");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setRole(role);
        user.setDepartment(department);
        user.setDesignation(designation);
        user.setStatus(status != null ? status : "ACTIVE");

        if ("edit".equals(action)) {
            user.setUserId(Integer.parseInt(request.getParameter("userId")));
            userDAO.updateUser(user);
        } else {
            user.setPin(pin);
            userDAO.addUser(user);
        }

        response.sendRedirect(request.getContextPath() + "/admin/user");
    }

    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/employee/dashboard");
            return false;
        }
        return true;
    }
}