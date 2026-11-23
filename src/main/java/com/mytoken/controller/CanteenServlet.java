package com.mytoken.controller;

import java.io.IOException;
import java.util.List;

import com.mytoken.dao.CanteenDAO;
import com.mytoken.model.Canteen;
import com.mytoken.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CanteenServlet extends HttpServlet {

    private CanteenDAO canteenDAO = new CanteenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                request.getRequestDispatcher("/WEB-INF/views/admin/canteen-form.jsp")
                       .forward(request, response);
                break;
            case "edit":
                int canteenId = Integer.parseInt(request.getParameter("id"));
                Canteen canteen = canteenDAO.getCanteenById(canteenId);
                request.setAttribute("canteen", canteen);
                request.getRequestDispatcher("/WEB-INF/views/admin/canteen-form.jsp")
                       .forward(request, response);
                break;
            case "toggle":
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                canteenDAO.updateStatus(id, status);
                response.sendRedirect(request.getContextPath() + "/admin/canteen");
                break;
            default:
                List<Canteen> canteens = canteenDAO.getAllCanteens();
                request.setAttribute("canteens", canteens);
                request.getRequestDispatcher("/WEB-INF/views/admin/canteen-list.jsp")
                       .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String openingTime = request.getParameter("openingTime");
        String closingTime = request.getParameter("closingTime");
        String status = request.getParameter("status");

        Canteen canteen = new Canteen();
        canteen.setName(name);
        canteen.setOpeningTime(openingTime);
        canteen.setClosingTime(closingTime);
        canteen.setStatus(status != null ? status : "ACTIVE");

        if ("edit".equals(action)) {
            canteen.setCanteenId(Integer.parseInt(request.getParameter("canteenId")));
            canteenDAO.updateCanteen(canteen);
        } else {
            canteenDAO.addCanteen(canteen);
        }

        response.sendRedirect(request.getContextPath() + "/admin/canteen");
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