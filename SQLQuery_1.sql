create DATABASE carImages; 
create table dbo.Images (id int primary key, img varbinary(max) , img_date datetime)

protected void Button1_Click(object sender, EventArgs e)  
    {          
        if (!FileUpload1.HasFile) //Validation  
        {  
            Response.Write("  No file Selected"); return;  
        }  
        else  
        {  
            string filename = FileUpload1.PostedFile.FileName;  
  
            //convert the image into the byte  
            byte[] imageByte = System.IO.File.ReadAllBytes(filename);  
  
            //Insert the Data in the Table  
            using (SqlConnection connection = new SqlConnection())  
            {  
 connection.ConnectionString = ConfigurationManager.ConnectionStrings["constr"].ToString();  
                
  connection.Open();  
                SqlCommand cmd = new SqlCommand();  
                cmd.Connection = connection;  
  
  string commandText = "Insert into Images values (@Rollno,@image,getdate())";  
  
                cmd.CommandText = commandText;  
                cmd.CommandType = CommandType.Text;  
                cmd.Parameters.Add("@image", SqlDbType.VarBinary);  
                cmd.Parameters["@image"].Value = imageByte;  
                cmd.Parameters.Add("@Rollno", SqlDbType.VarChar);  
                cmd.Parameters["@Rollno"].Value = txtrollno.Text;  
                cmd.ExecuteNonQuery();  
                cmd.Dispose();  
                connection.Close();  
  
                Response.Write("Data has been Added");  
            }  
        }  
    } 