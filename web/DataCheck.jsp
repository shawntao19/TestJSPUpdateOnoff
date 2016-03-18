<%@ page contentType="text/html; charset=GB2312" %>
<%@ page	import="java.sql.*" %>
<%@ page language="java" %>
<HTML>
    <HEAD>
        <TITLE>摄像头查询上下线情况</TITLE>
    </HEAD>
    <BODY>
    <CENTER>
        <FONT SIZE = 5 COLOR = blue>查询15天内的摄像头上下线情况</FONT>
    </CENTER>
    <BR>
    <HR>
    <BR>
    <!--<FONT SIZE = 4 COLOR = red>通过数据检查!!</FONT>-->
    <P>查询的设备码是:"<%= request.getParameter("tmpName")%>"</P>
    <!--<P>E-Mail帐号为"<%= request.getParameter("tmpE_Mail")%>"</P>-->

    <CENTER>
        <%
            String sqlIP = "192.168.102.99";
            Class.forName("com.mysql.jdbc.Driver"); //载入驱动程序类别
            Connection con = DriverManager.getConnection("jdbc:Mysql://" + sqlIP + ":3306", "wex", "eewq"); //建立数据库链接
            Statement stmt = con.createStatement(); //建立Statement对象
            ResultSet rs; //建立ResultSet(结果集)对象
            String devID = request.getParameter("tmpName");
            String dosql1 = "select *  from cee.monitoringonlinelog WHERE   DATE_SUB(CURDATE(), INTERVAL 15 DAY) <= date(actionTime) and monitoringId in (select ID from cee.monitoring where CAMERAID in  (select ID from cee.camera where serialNumber='";
            String dosql2 = "'))   and CATEGORY!=4 order by actionTime desc;";
            StringBuilder builder = new StringBuilder("");
            String dosql = builder.append(dosql1).append(devID).append(dosql2).toString();
//            String dosql = "select *  from cee.monitoringonlinelog WHERE   DATE_SUB(CURDATE(), INTERVAL 15 DAY) <= date(actionTime) and monitoringId in (select ID from cee.monitoring where CAMERAID in  (select ID from cee.camera where serialNumber='85025000002'))   and CATEGORY!=4 order by actionTime desc;";
            rs = stmt.executeQuery(dosql); //执行SQL语句
        %>
        <TABLE  bgcolor=pink>
            <TR  bgcolor=silver>	
                <TD><B>monitoringId</B></TD><TD><B>产生时间</B></TD><TD><B>CATEGORY(1上线，2下线，3发出离线告警)</B></TD>	
            </TR>	
            <%
                //利用while循环将数据表中的记录列出
                while (rs.next()) {
            %>
            <TR bgcolor=white>
                <TD><B><%= rs.getString("monitoringId")%></B></TD>
                <TD><B><%= rs.getString("actionTime")%></B></TD>
                <TD><B><%= rs.getString("CATEGORY")%></B></TD>			
            </TR>
            <%
                }
                rs.close(); //关闭ResultSet对象
                stmt.close(); //关闭Statement对象
                con.close();  //关闭Connection对象	
            %>	
        </TABLE>
    </CENTER>
</BODY>
</HTML>