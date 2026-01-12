<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>University Club Management System</title>
    <link href="css/style.css" rel="stylesheet">
    <script src="js/script.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
    <header class="bg-blue-600 text-white p-4 shadow-md">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold">UCMS</h1>
            <nav>
                <a href="login.jsp" class="px-4 py-2 hover:bg-blue-500 rounded">Login</a>
                <a href="register.jsp" class="px-4 py-2 hover:bg-blue-500 rounded">Register</a>
            </nav>
        </div>
    </header>

    <main class="container mx-auto my-12 text-center">
        <h2 class="text-4xl font-bold mb-6">Welcome to University Club Management System</h2>
        <p class="text-gray-700 text-lg mb-6">Explore clubs, join events, and manage your campus activities with ease!</p>
        <a href="register.jsp" class="bg-blue-600 text-white px-6 py-3 rounded shadow hover:bg-blue-500">Get Started</a>
    </main>
</body>
</html>
