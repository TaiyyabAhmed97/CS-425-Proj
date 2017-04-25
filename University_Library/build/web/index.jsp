<%-- 
    Document   : index
    Created on : Apr 25, 2017, 5:15:22 PM
    Author     : Taiyyab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Illinois Institute of Technology</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h1>Welcome to Library</h1><table border="0">
            <thead>
                <tr>
                    <th>IIT is a University</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>IIT is a very good University</td>
                </tr>
                <tr>
                    <td><form action="response.jsp">
                            <strong>Select a subject:</strong>
                            <select name="subject_id">
                                <option>student_id</option>
                                <option>student_name</option>
                                <option>student_classes</option>
                                <option>student_fines</option><input type="submit" value="submit" />
                            </select>

                        </form>
                    </td>
                </tr>
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                </tr>
            </tbody>
        </table>

    </body>
</html>
