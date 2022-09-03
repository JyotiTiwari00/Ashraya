﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Display All Bookings</title>
    <link href="../../../Contents/CSS3/AdminDashboard/DisplayAllUsers/customer.css" rel="stylesheet" />
    <link href="../../../Contents/CSS3/AdminDashboard/DisplayAllUsers/customerbooking.css" rel="stylesheet" />
    <link href="../../../Contents/CSS3/AdminDashboard/DisplayAllUsers/logincss.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <style>
        .swal-modal {
    height: fit-content;
    position: relative;
    top: 33%;
}
        .swal-overlay {
  background-color: rgb(0,0,0,0.9);
}
    </style>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Data.SqlClient.SqlConnection Con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["AshrayaConnectionString"].ConnectionString);
        System.Data.SqlClient.SqlCommand Owner = new System.Data.SqlClient.SqlCommand("Select Count(*) From Booking B,Registration_Table R  Where (R.ID=B.Customer_ID);", Con);
        Con.Open();
        int COunt_Owner = Convert.ToInt32(Owner.ExecuteScalar().ToString());
        Con.Close();
        if (COunt_Owner == 0)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", " Empty();", true);
        }
        else if (!IsPostBack)
        {

            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["AshrayaConnectionString"].ConnectionString))
            {
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("Select Room_ID,Customer_ID,Check_In_Date,Check_Out_Date,No_Of_People,Booking_Date From Booking;", con);
                //     cmd.CommandType = CommandType.TableDirect;
                con.Open();
                DataList1.DataSource = cmd.ExecuteReader();
                DataList1.DataBind();
                con.Close();
            }

        }
    }
</script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="../../../Contents/Javascript/NoData.js"></script>

</head>
<body>
  <div class="main">
  <div class="wrapper" style="z-index:1">
   <nav>
      <input type="checkbox" id="show-search">
      <input type="checkbox" id="show-menu">
      <label for="show-menu" class="menu-icon"><i class="fas fa-bars"></i></label>
      <div class="content">
     <div class="logo"><a href='<%= Url.Action("AdminLogin", "Ashraya") %>'>Ashraya</a></div>
       <ul class="links">
          <li><a href=<%= Url.Action("Index", "Ashraya") %>>Home</a></li>
          <li><a href=<%= Url.Action("AboutUS", "Ashraya") %>>About Us</a></li>
          <li><a href='<%= Url.Action("Contact", "Ashraya") %>'>Contact Us</a></li>
          
             <li>
            <a href="#" class="desktop-link">Admin&nbsp;&nbsp;&nbsp;</a>
            <input type="checkbox" id="show-features">
            <label for="show-features">Customer</label>
          <ul>
                 <li><a href='<%= Url.Action("AdminDashboard", "Ashraya") %>'>Dashboard</a></li>
                <li><a href='<%= Url.Action("VerficationData", "Ashraya") %>'>Documents</a></li>
                <li><a href='<%= Url.Action("AdminProfileUpdate", "Ashraya") %>'>Change Password</a></li>
              <li><a href='<%= Url.Action("Logout", "Ashraya") %>'>Logout</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>  
  </div>
        <div class="table_responsive" style="z-index:0;height: 341px;width: 100%;">
      <form runat="server"><!-- style="position: inherit;z-index: -1;margin-left: 4%;width: 91%;margin-top: 21%;">-->
      <asp:DataList ID="DataList1" runat="server">
          <ItemTemplate>

    <table>
      <thead>
        <tr>
          <th>Room ID</th>
          <th>Customer ID</th>
          <th>Check In Date</th>
          <th>Check Out Date</th>
          <th>No Of People</th>
           <th>Booking Date</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td data-label="Room ID"><%#Eval("Room_ID") %></td>
          <td data-label="Customer ID"><%#Eval("Customer_ID") %></td>
          <td data-label="Check In Date"><%#Eval("Check_In_Date") %></td>
          <td data-label="Check Out Date"><%#Eval("Check_Out_Date") %></td>
          <td data-label="No Of People"><%#Eval("No_Of_People") %></td>
           <td data-label="Booking Date"><%#Eval("Booking_Date") %></td>
          </tr>
      </tbody>
    </table>
  </div>
    </ItemTemplate>
</asp:DataList>
          </form>
</div>
</body>
</html>
