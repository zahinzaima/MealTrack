package com.mytoken.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.mytoken.dao.BookingDAO;
import com.mytoken.dao.TokenDAO;
import com.mytoken.model.Booking;
import com.mytoken.model.Token;
import com.mytoken.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class EmployeeDashboardServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();
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
        int userId = user.getUserId();

        // Current month bookings
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);

        List<Booking> myBookings = bookingDAO.getBookingsByUser(userId);
        double monthlyTotal = bookingDAO.getMonthlyTotal(userId, month, year);

        // Tomorrow's available tokens
        cal.add(Calendar.DATE, 1);
        Date tomorrow = cal.getTime();
        List<Token> availableTokens = tokenDAO.getTokensByDate(tomorrow);

        request.setAttribute("myBookings", myBookings);
        request.setAttribute("monthlyTotal", monthlyTotal);
        request.setAttribute("availableTokens", availableTokens);
        request.setAttribute("currentMonth", month);
        request.setAttribute("currentYear", year);

        request.getRequestDispatcher("/WEB-INF/views/employee/dashboard.jsp")
               .forward(request, response);
    }
}