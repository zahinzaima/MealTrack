<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyToken - ${pageTitle}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f5f5f5; }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background: white;
            height: 100vh;
            position: fixed;
            left: 0; top: 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.08);
            display: flex;
            flex-direction: column;
            z-index: 100;
        }
        .sidebar-logo {
            padding: 25px 20px;
            border-bottom: 1px solid #f0f0f0;
        }
        .sidebar-logo h2 {
            color: #e91e8c;
            font-size: 22px;
            font-weight: 700;
        }
        .sidebar-logo p { color: #999; font-size: 12px; }

        .nav-section { padding: 10px 0; }
        .nav-label {
            padding: 8px 20px;
            font-size: 11px;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }
        .nav-item {
            display: flex;
            align-items: center;
            padding: 11px 20px;
            color: #555;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.2s;
            gap: 10px;
        }
        .nav-item:hover, .nav-item.active {
            background: #fce4ec;
            color: #e91e8c;
            border-right: 3px solid #e91e8c;
        }
        .nav-item span.icon { font-size: 18px; }

        /* Topbar */
        .topbar {
            margin-left: 260px;
            background: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            position: sticky;
            top: 0;
            z-index: 99;
        }
        .topbar h3 { color: #333; font-size: 18px; }
        .topbar-right { display: flex; align-items: center; gap: 15px; }
        .user-info { text-align: right; }
        .user-info span { display: block; }
        .user-name { font-weight: 600; color: #333; font-size: 14px; }
        .user-role {
            font-size: 11px;
            color: white;
            background: #e91e8c;
            padding: 2px 8px;
            border-radius: 10px;
        }
        .btn-logout {
            padding: 8px 16px;
            background: #fff;
            color: #e91e8c;
            border: 1.5px solid #e91e8c;
            border-radius: 8px;
            font-size: 13px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-logout:hover {
            background: #e91e8c;
            color: white;
        }

        /* Main Content */
        .main-content {
            margin-left: 260px;
            padding: 30px;
            min-height: calc(100vh - 60px);
        }

        /* Cards */
        .card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            margin-bottom: 20px;
        }
        .card-title {
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid #f0f0f0;
        }

        /* Stats */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            text-align: center;
        }
        .stat-number { font-size: 32px; font-weight: 700; color: #e91e8c; }
        .stat-label { color: #888; font-size: 13px; margin-top: 5px; }

        /* Table */
        table { width: 100%; border-collapse: collapse; }
        th {
            background: #f8f8f8;
            padding: 12px 15px;
            text-align: left;
            font-size: 13px;
            color: #666;
            font-weight: 600;
            border-bottom: 2px solid #eee;
        }
        td {
            padding: 12px 15px;
            border-bottom: 1px solid #f5f5f5;
            font-size: 14px;
            color: #444;
        }
        tr:hover td { background: #fafafa; }

        /* Buttons */
        .btn {
            padding: 8px 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            transition: all 0.2s;
        }
        .btn-primary { background: #e91e8c; color: white; }
        .btn-primary:hover { background: #c2185b; }
        .btn-secondary { background: #f5f5f5; color: #555; }
        .btn-secondary:hover { background: #eee; }
        .btn-danger { background: #ff5252; color: white; }
        .btn-danger:hover { background: #d32f2f; }
        .btn-success { background: #4caf50; color: white; }
        .btn-success:hover { background: #388e3c; }
        .btn-sm { padding: 5px 10px; font-size: 12px; }

        /* Badge */
        .badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        .badge-active { background: #e8f5e9; color: #2e7d32; }
        .badge-inactive { background: #ffebee; color: #c62828; }
        .badge-regular { background: #e3f2fd; color: #1565c0; }
        .badge-dry { background: #fff3e0; color: #e65100; }

        /* Alert */
        .alert {
            padding: 12px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .alert-success { background: #e8f5e9; color: #2e7d32; border-left: 4px solid #4caf50; }
        .alert-error { background: #ffebee; color: #c62828; border-left: 4px solid #f44336; }

        /* Form */
        .form-group { margin-bottom: 18px; }
        .form-group label {
            display: block;
            margin-bottom: 6px;
            color: #333;
            font-size: 14px;
            font-weight: 500;
        }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }
        .form-control:focus { border-color: #e91e8c; }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        /* Toggle */
        .toggle {
            position: relative;
            display: inline-block;
            width: 44px;
            height: 24px;
        }
        .toggle input { display: none; }
        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0; left: 0; right: 0; bottom: 0;
            background: #ccc;
            border-radius: 24px;
            transition: 0.3s;
        }
        .toggle-slider:before {
            content: "";
            position: absolute;
            width: 18px; height: 18px;
            left: 3px; bottom: 3px;
            background: white;
            border-radius: 50%;
            transition: 0.3s;
        }
        .toggle input:checked + .toggle-slider { background: #e91e8c; }
        .toggle input:checked + .toggle-slider:before { transform: translateX(20px); }

        /* Page header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .page-header h2 { color: #333; font-size: 22px; }
    </style>
</head>
<body>