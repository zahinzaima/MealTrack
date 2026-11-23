package com.mytoken.controller;

import java.io.IOException;
import java.util.List;

import com.mytoken.dao.BookingDAO;
import com.mytoken.dao.CanteenDAO;
import com.mytoken.dao.TokenDAO;
import com.mytoken.dao.UserDAO;
import com.mytoken.model.Booking;
import com.mytoken.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminDashboardServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();
    private UserDAO userDAO = new UserDAO();
    private CanteenDAO canteenDAO = new CanteenDAO();
    private TokenDAO tokenDAO = new TokenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/employee/dashboard");
            return;
        }

        List<Booking> todayBookings = bookingDAO.getTodayBookings();
        int totalUsers = userDAO.getAllUsers().size();
        int totalCanteens = canteenDAO.getAllCanteens().size();
        int totalTokens = tokenDAO.getAllTokens().size();

        request.setAttribute("todayBookings", todayBookings);
        request.setAttribute("todayBookingCount", todayBookings.size());
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalCanteens", totalCanteens);
        request.setAttribute("totalTokens", totalTokens);

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
               .forward(request, response);
    }
}