<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - UCMS</title>
    <link href="css/style.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex justify-center items-center h-screen">
    <div class="bg-white p-10 rounded-lg shadow-lg w-full max-w-md">
        <h1 class="text-3xl font-bold mb-6 text-center">Login</h1>
        <form action="LoginServlet" method="post" class="space-y-4">
            <input type="email" name="email" placeholder="Email" required
                   class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
            <input type="password" name="password" placeholder="Password" required
                   class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
            <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-500">Login</button>
        </form>
        <p class="mt-4 text-center">Don't have an account? <a href="register.jsp" class="text-blue-600 hover:underline">Register</a></p>
    </div>
</body>
</html>
