package com.mytoken.controller;

import java.io.IOException;
import java.util.List;

import com.mytoken.dao.CanteenDAO;
import com.mytoken.dao.TokenDAO;
import com.mytoken.model.Token;
import com.mytoken.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class TokenServlet extends HttpServlet {

    private TokenDAO tokenDAO = new TokenDAO();
    private CanteenDAO canteenDAO = new CanteenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                request.setAttribute("canteens", canteenDAO.getActiveCanteens());
                request.getRequestDispatcher("/WEB-INF/views/admin/token-form.jsp")
                       .forward(request, response);
                break;
            case "edit":
                int tokenId = Integer.parseInt(request.getParameter("id"));
                Token token = tokenDAO.getTokenById(tokenId);
                request.setAttribute("token", token);
                request.setAttribute("canteens", canteenDAO.getActiveCanteens());
                request.getRequestDispatcher("/WEB-INF/views/admin/token-form.jsp")
                       .forward(request, response);
                break;
            case "toggle":
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                tokenDAO.updateStatus(id, status);
                response.sendRedirect(request.getContextPath() + "/admin/token");
                break;
            default:
                List<Token> tokens = tokenDAO.getAllTokens();
                request.setAttribute("tokens", tokens);
                request.getRequestDispatcher("/WEB-INF/views/admin/token-list.jsp")
                       .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        String tokenCode = request.getParameter("tokenCode");
        String tokenName = request.getParameter("tokenName");
        int canteenId = Integer.parseInt(request.getParameter("canteenId"));
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        String[] days = request.getParameterValues("days");
        String status = request.getParameter("status");

        String availableDays = "";
        if (days != null) {
            availableDays = String.join(",", days);
        }

        Token token = new Token();
        token.setTokenCode(tokenCode);
        token.setTokenName(tokenName);
        token.setCanteenId(canteenId);
        token.setCategory(category);
        token.setPrice(price);
        token.setAvailableDays(availableDays);
        token.setStatus(status != null ? status : "ACTIVE");

        if ("edit".equals(action)) {
            token.setTokenId(Integer.parseInt(request.getParameter("tokenId")));
            tokenDAO.updateToken(token);
        } else {
            tokenDAO.addToken(token);
        }

        response.sendRedirect(request.getContextPath() + "/admin/token");
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