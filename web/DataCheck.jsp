<%@ page contentType="text/html; charset=GB2312" %>
<%@ page	import="java.sql.*" %>
<%@ page language="java" %>
<HTML>
    <HEAD>
        <TITLE>����ͷ��ѯ���������</TITLE>
    </HEAD>
    <BODY>
    <CENTER>
        <FONT SIZE = 5 COLOR = blue>��ѯ15���ڵ�����ͷ���������</FONT>
    </CENTER>
    <BR>
    <HR>
    <BR>
    <!--<FONT SIZE = 4 COLOR = red>ͨ�����ݼ��!!</FONT>-->
    <P>��ѯ���豸����:"<%= request.getParameter("tmpName")%>"</P>
    <!--<P>E-Mail�ʺ�Ϊ"<%= request.getParameter("tmpE_Mail")%>"</P>-->

    <CENTER>
        <%
            String sqlIP = "192.168.102.99";
            Class.forName("com.mysql.jdbc.Driver"); //���������������
            Connection con = DriverManager.getConnection("jdbc:Mysql://" + sqlIP + ":3306", "wex", "eewq"); //�������ݿ�����
            Statement stmt = con.createStatement(); //����Statement����
            ResultSet rs; //����ResultSet(�����)����
            String devID = request.getParameter("tmpName");
            String dosql1 = "select *  from cee.monitoringonlinelog WHERE   DATE_SUB(CURDATE(), INTERVAL 15 DAY) <= date(actionTime) and monitoringId in (select ID from cee.monitoring where CAMERAID in  (select ID from cee.camera where serialNumber='";
            String dosql2 = "'))   and CATEGORY!=4 order by actionTime desc;";
            StringBuilder builder = new StringBuilder("");
            String dosql = builder.append(dosql1).append(devID).append(dosql2).toString();
//            String dosql = "select *  from cee.monitoringonlinelog WHERE   DATE_SUB(CURDATE(), INTERVAL 15 DAY) <= date(actionTime) and monitoringId in (select ID from cee.monitoring where CAMERAID in  (select ID from cee.camera where serialNumber='85025000002'))   and CATEGORY!=4 order by actionTime desc;";
            rs = stmt.executeQuery(dosql); //ִ��SQL���
        %>
        <TABLE  bgcolor=pink>
            <TR  bgcolor=silver>	
                <TD><B>monitoringId</B></TD><TD><B>����ʱ��</B></TD><TD><B>CATEGORY(1���ߣ�2���ߣ�3�������߸澯)</B></TD>	
            </TR>	
            <%
                //����whileѭ�������ݱ��еļ�¼�г�
                while (rs.next()) {
            %>
            <TR bgcolor=white>
                <TD><B><%= rs.getString("monitoringId")%></B></TD>
                <TD><B><%= rs.getString("actionTime")%></B></TD>
                <TD><B><%= rs.getString("CATEGORY")%></B></TD>			
            </TR>
            <%
                }
                rs.close(); //�ر�ResultSet����
                stmt.close(); //�ر�Statement����
                con.close();  //�ر�Connection����	
            %>	
        </TABLE>
    </CENTER>
</BODY>
</HTML>