﻿using LibraryManagement.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LibraryManagement.DAO
{
    public class LibraryDAO
    {
        public DataTable LoadDataBOOK()
        {
            string sql = "Select b.BOOK_ID as N'Mã sách',b.NAME as N'Tên sách', b.AUTHOR as 'Tác giả',Ph.NAME as N'Tên nhà xuất bản',bt.BTYPE as N'Thể loại',b.PRICE as N'Giá bán', b.AMOUNT as N'Số lượng', b.SUMMARY as N'Tóm tắt',b.PUBLISH_YEAR as N'Ngày xuất bản' from BOOK b,PUBLISHING_HOUSE ph, BOOK_TYPE bt Where b.BTYPE_ID = bt.BTYPE_ID AND b.PH_ID = ph.PH_ID";
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable LoadDataBOOK_TYPE()
        {
            string sql = "Select BTYPE_ID as N'Mã số', BTYPE AS N'Thể loại'from BOOK_TYPE";
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public DataTable LoadDataPUBLISHING_HOUSE()
        {
            string sql = "Select PH_ID as N'Mã nhà xuất bản', Name as N'Tên nhà xuất bản', PH_ADDRESS as N'Địa chỉ',PHONE_NUMBER as 'Số Điện thoại', EMAIL as 'Email' from PUBLISHING_HOUSE";
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable LoadDataREADER()
        {
            string sql = "Select READER_ID as N'Mã độc giả',NAME as N'Tên độc giả',DATE_OF_BIRTH as N'Ngày sinh',READER_ADDRESS as N'Địa chi',GENDER as N'Giới tính',PHONE_NUMBER as N'Số điện thoại',EMAIL as 'Email' from READER";
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public int InsertBook_type(Book_type bt)
        {
            string sql = string.Format("Insert into BOOK_TYPE values (N'{0}')", bt.BType);

            var rs = ProcessData.Execute(sql);

            return rs;
        }
        public int EditBook_type(Book_type bt)
        {
            string sql = string.Format("Update BOOK_TYPE Set BTYPE = N'{1}' Where BTYPE_ID={0}", bt.Id, bt.BType);
            var rs = ProcessData.Execute(sql);
            return rs;
        }

        public DataTable CheckBook_typeValid(string query)
        {
            string sql = string.Format("SELECT NAME FROM BOOK, BOOK_TYPE WHERE BOOK.BTYPE_ID = BOOK_TYPE.BTYPE_ID AND BOOK_TYPE.BTYPE =N'{0}'", query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public int DeleteBook_type(int id)
        {
            string sql = string.Format("Delete from BOOK_TYPE Where BTYPE_ID = '{0}'", id);
            var rs = ProcessData.Execute(sql);

            return rs;
        }

        public DataTable SearchBook_type(string query)
        {
            string sql = string.Format("Select BTYPE_ID as N'Mã số', BTYPE as N'Thể loại' from BOOK_TYPE Where FREETEXT(BTYPE,N'{0}')", query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public int InsertPublish_House(Publishing_house ph)
        {
            string sql = string.Format("Insert into PUBLISHING_HOUSE values ('',N'{0}',N'{1}','{2}','{3}')", ph.Name, ph.PH_address, ph.Phone_number, ph.Email);

            var rs = ProcessData.Execute(sql);

            return rs;
        }
        public int EditPublish_House(Publishing_house ph)
        {
            string sql = string.Format("Update PUBLISHING_HOUSE Set Name = N'{1}',PH_ADDRESS= N'{2}',PHONE_NUMBER = '{3}',EMAIL = '{4}' Where PH_ID='{0}'", ph.PH_Id, ph.Name, ph.PH_address, ph.Phone_number, ph.Email);
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public DataTable CheckPublish_house(string query)
        {
            string sql = string.Format("SELECT BOOK.NAME FROM BOOK, PUBLISHING_HOUSE WHERE BOOK.PH_ID = PUBLISHING_HOUSE.PH_ID AND PUBLISHING_HOUSE.NAME =N'{0}'", query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public int DeletePublish_House(string id)
        {
            string sql = string.Format("Delete from PUBLISHING_HOUSE Where PH_ID = '{0}'", id);
            var rs = ProcessData.Execute(sql);

            return rs;
        }
        public DataTable SearchPublish_House(string column, string query)
        {
            string sql = string.Format("Select PH_ID as N'Mã nhà xuất bản', Name as N'Tên nhà xuất bản', PH_ADDRESS as N'Địa chỉ',PHONE_NUMBER as 'Số Điện thoại', EMAIL as 'Email' from PUBLISHING_HOUSE Where FREETEXT({0},N'{1}')", column, query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable GetDataNamePH()
        {
            string sql = string.Format("Select NAME from PUBLISHING_HOUSE");
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable GetDataBookTypeName()
        {
            string sql = string.Format("Select BTYPE from BOOK_TYPE");
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public int InsertReader(Reader rd)
        {
            string sql = string.Format("Insert into READER values ('',N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}')", rd.Name, rd.Date_of_birth, rd.Addres, rd.Gender, rd.Phone_number, rd.Email);

            var rs = ProcessData.Execute(sql);

            return rs;
        }
        public int EditReader(Reader rd)
        {
            string sql = string.Format("Update READER Set NAME = N'{1}',DATE_OF_BIRTH= N'{2}',READER_ADDRESS = N'{3}',GENDER = N'{4}',PHONE_NUMBER=N'{5}',EMAIL=N'{6}' Where READER_ID='{0}'", rd.Reader_Id, rd.Name, rd.Date_of_birth, rd.Addres, rd.Gender, rd.Phone_number, rd.Email);
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public int DeleteReader(string id)
        {
            string sql = string.Format("Delete from READER Where READER_ID = '{0}'", id);
            var rs = ProcessData.Execute(sql);

            return rs;
        }
        public DataTable SearchReader(string column, string query)
        {
            string sql = string.Format("Select READER_ID as N'Mã độc giả',NAME as N'Tên độc giả',DATE_OF_BIRTH as N'Ngày sinh',READER_ADDRESS as N'Địa chỉ',GENDER as N'Giới tính',PHONE_NUMBER as N'Số điện thoại',EMAIL as 'Email' from READER Where FREETEXT({0},N'{1}')", column, query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable GetIDFromNameNXB(string query)
        {
            string sql = string.Format("Select PH_ID From PUBLISHING_HOUSE WHERE NAME = N'{0}'", query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public DataTable GetIDFromNameBookType(string query)
        {
            string sql = string.Format("Select BTYPE_ID From BOOK_TYPE WHERE BTYPE = N'{0}'", query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public int InsertBook(Book b, string ph, int bt)
        {
            string sql = string.Format("Insert into BOOK values ('',N'{0}',N'{1}','{2}',{3},{4},{5},N'{6}','{7}')", b.Name, b.author, ph, bt, b.price, b.amount, b.summary, b.publish_year);
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public int EditBook(Book b, string ph, int bt)
        {
            string sql = string.Format("Update BOOK Set NAME = N'{1}',AUTHOR= N'{2}',PH_ID = '{3}',BTYPE_ID = {4},PRICE = {5},AMOUNT={6},SUMMARY=N'{7}',PUBLISH_YEAR='{8}' Where BOOK_ID='{0}'", b.ph_id, b.Name, b.author, ph, bt, b.price, b.amount, b.summary, b.publish_year);
            var rs = ProcessData.Execute(sql);
            return rs;
        }

        public int DeleteBook(string id)
        {
            string sql = string.Format("Delete from BOOK Where BOOK_ID = '{0}'", id);
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public DataTable SearchBook(string column, string query)
        {
            string sql = string.Format("Select BOOK_ID as N'Mã sách', b.NAME as N'Tên sách', AUTHOR as N'Tác giả',ph.Name as N'Nhà xuất bản', bt.BTYPE as 'Thể loại',PRICE as N'Giá bán',AMOUNT as N'Số lượng', SUMMARY as N'Tóm tắt', PUBLISH_YEAR as N'Ngày xuất bản' from BOOK b,PUBLISHING_HOUSE ph, BOOK_TYPE bt Where FREETEXT(b.{0},N'{1}') and b.PH_ID = ph.PH_ID and b.BTYPE_ID = bt.BTYPE_ID", column, query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable FindAccount(string username, string password)
        {
            string sql = string.Format("Select Role FROM ACCOUNT where USERNAME='{0}' and PASS='{1}'", username, password);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public DataTable LoadDataEmployee(string username)
        {
            string sql = string.Format("Select * FROM EMPLOYEE Where USERNAME = '{0}'", username);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public int EditEmployee(Employee ep)
        {
            string sql = string.Format("Update EMPLOYEE SET NAME=N'{2}',EMPLOYEE_ADDRESS=N'{3}',EMAIL='{4}',PHONE_NUMBER='{5}',DATE_OF_BIRTH='{6}',GENDER=N'{7}' WHERE USERNAME ='{1}'", ep.Employee_ID, ep.UserName, ep.Name, ep.Employee_Addres, ep.Email, ep.Phone_number, ep.Date_of_birth, ep.Gender);
            var rs = ProcessData.Execute(sql);
            return rs;
        }

        public DataTable LoadDataAccount(string us)
        {
            string sql = string.Format("Select PASS from ACCOUNT WHERE USERNAME ='{0}'", us);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public int EditPasswordAccount(string us, string pw)
        {
            string sql = string.Format("Update ACCOUNT SET PASS ='{1}' WHERE USERNAME ='{0}'", us, pw);
            var rs = ProcessData.Execute(sql);
            return rs;
        }

        public DataTable LoadDataNhanVien(string username)
        {
            string sql = string.Format("Select * from EMPLOYEE WHERE USERNAME !='{0}'", username);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable FindNameAccount(string username)
        {
            string sql = string.Format("Select NAME FROM EMPLOYEE WHERE USERNAME ='{0}'", username);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable LoadDataBorrow_Form()
        {
            string sql = string.Format("SELECT FORM_ID AS N'Mã phiếu', READER.NAME AS N'Độc giả', EMPLOYEE.EMPLOYEE_ID AS N'Mã nhân viên', LOAN_DATE AS N'Ngày mượn', EXP_DATE AS N'Ngày trả', DEPOSIT AS N'Phí' FROM BORROW_FORM, READER, EMPLOYEE WHERE BORROW_FORM.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID and READER.READER_ID = BORROW_FORM.READER_ID ");
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        
        public DataTable LoadDataBorrow_FormDetails(string form_id)
        {
            string sql = string.Format("SELECT bfd.ID, b.BOOK_ID as N'Mã sách' ,b.NAME as N'Tên sách', bt.BTYPE as N'Tên thể loại', b.PRICE as N'Giá sách' FROM BOOK b,BORROW_DETAILS bfd, BORROW_FORM bf, BOOK_TYPE bt WHERE bfd.FORM_ID = bf.FORM_ID AND bfd.BOOK_ID = b.BOOK_ID AND bt.BTYPE_ID = b.BTYPE_ID and bf.FORM_ID ='{0}' order by b.BOOK_ID asc", form_id);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public DataTable GetIDFromNameBook()
        {
            string sql = string.Format("Select BOOK_ID From BOOK");
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public DataTable GetIDFromReader()
        {
            string sql = string.Format("Select READER_ID,NAME From READER");
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public int InsertBorrowForm(Borrow_Form bf)
        {
            string sql = string.Format("INSERT INTO BORROW_FORM VALUES ('','{0}','{1}','{2}','{3}',{4})", bf.Reader_ID, bf.Employee_ID, bf.LOAN_date, bf.EXP_date, bf.Deposit);
            var rs = ProcessData.Execute(sql);
            return rs;
        }

        public int InsertBorrowFormDetails(Borrow_Details bd)
        {
            string sql = string.Format("INSERT INTO BORROW_DETAILS VALUES ('','{0}','{1}',{2})", bd.Form_ID, bd.BOOK_ID, bd.Amount);
            var rs = ProcessData.Execute(sql);
            return rs;
        }

        public DataTable GetIDFromBorrowForm()
        {
            string sql = string.Format("Select FORM_ID From BORROW_FORM");
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public int EditBorrowForm(Borrow_Form bf)
        {
            string sql = string.Format("UPDATE BORROW_FORM SET READER_ID ='{1}',LOAN_DATE ='{2}', EXP_DATE='{3}',DEPOSIT={4} WHERE FORM_ID = '{0}' ", bf.Form_ID,bf.Reader_ID, bf.LOAN_date, bf.EXP_date, bf.Deposit);
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public int EditBorrowFormDetails(Borrow_Details bd)
        {
            string sql = string.Format("UPDATE BORROW_DETAILS SET BOOK_ID = '{1}', AMOUNT = {2} WHERE ID ='{0}'",bd.ID,bd.BOOK_ID, bd.Amount); 
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public DataTable CheckBorrowFormDetailsValid(string query)
        {
            string sql = string.Format("SELECT bd.FORM_ID FROM BORROW_FORM bf, BORROW_DETAILS bd WHERE bf.FORM_ID = bd.FORM_ID AND bf.FORM_ID ='{0}' ",query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public int DeleteBorrowForm_Details(string query)
        {
            string sql = string.Format("DELETE from BORROW_DETAILS WHERE ID='{0}'", query);
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public int DeleteBorrowForm(string query)
        {
             string sql = string.Format("DELETE from BORROW_FORM WHERE FORM_ID = '{0}'", query);
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public DataTable LoadDataPayForm()
        {
            string sql = string.Format("SELECT ID as N'Mã phiếu trả',BORROW_ID as N'Mã phiếu mượn',Employee_ID as N'Nhân viên lập phiếu', PAY_DATE as N'Ngày trả' FROM PAY_FORM");
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable GetTienBook(string query)
        {
            string sql = string.Format("SELECT PRICE FROM BOOK WHERE BOOK_ID = '{0}'",query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public int UpdateGiaTien()
        {
            string sql = string.Format("UPDATE BORROW_FORM SET DEPOSIT = (SELECT SUM(AMOUNT) AS N'Tổng tiền' FROM BORROW_DETAILS WHERE BORROW_FORM.FORM_ID = BORROW_DETAILS.FORM_ID)");
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public int UpdateTienCoc()
        {
            string sql = string.Format("UPDATE BORROW_DETAILS SET AMOUNT = (SELECT PRICE FROM BOOK WHERE BORROW_DETAILS.BOOK_ID = BOOK.BOOK_ID)");
            var rs = ProcessData.Execute(sql);
            return rs;
        }

        public DataTable LoadDataPay_FormDetails(string payformId)
        {
            string sql = string.Format("SELECT DISTINCT PAY_DETAILS.ID AS N'Mã phiếu', PAY_DETAILS.BOOK_ID as N'Mã sách', BOOK.NAME as N'Tên sách',PAY_DETAILS.AMOUNT as N'Tiền phạt' FROM PAY_DETAILS,BOOK,PAY_FORM, BORROW_DETAILS WHERE BOOK.BOOK_ID = PAY_DETAILS.BOOK_ID AND PAY_DETAILS.FORM_ID = PAY_FORM.ID  AND PAY_FORM.ID ='{0}'",payformId);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
    
        public DataTable CheckBookIDHaveBorrowDetails(string book_id)
        {
            string sql = string.Format("SELECT BOOK_ID FROM BORROW_DETAILS,BORROW_FORM WHERE BORROW_FORM.FORM_ID = BORROW_DETAILS.FORM_ID AND BORROW_DETAILS.FORM_ID ='{0}'", book_id);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable GetSoLuongSach(string query)
        {
            string sql = string.Format("SELECT AMOUNT FROM BOOK WHERE BOOK_ID = '{0}'", query);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public int UpDateSoLuongBook(string soluong,string masach)
        {
            string sql = string.Format("UPDATE BOOK SET AMOUNT ='{1}' WHERE BOOK_ID ='{0}'",masach,soluong);
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public DataTable GetTienCoc(string id)
        {
            string sql = string.Format("SELECT DISTINCT BORROW_DETAILS.AMOUNT FROM BORROW_DETAILS, PAY_DETAILS WHERE BORROW_DETAILS.BOOK_ID = PAY_DETAILS.BOOK_ID AND PAY_DETAILS.ID ='{0}'",id);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
        public DataTable GetMaDocGia(string id)
        {
            string sql = string.Format("SELECT DISTINCT BORROW_FORM.READER_ID FROM BORROW_DETAILS, PAY_DETAILS,BORROW_FORM WHERE BORROW_DETAILS.BOOK_ID = PAY_DETAILS.BOOK_ID AND BORROW_FORM.FORM_ID = BORROW_DETAILS.FORM_ID AND BORROW_FORM.FORM_ID ='{0}'", id);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public int InsertPayForm(Pay_form pf)
        {
            string sql = string.Format("INSERT INTO PAY_FORM VALUES('','{0}','{1}','{2}')", pf.Borrow_form, pf.Employee_id, pf.Pay_date);
            var rs = ProcessData.Execute(sql);
            return rs;
        }
        public DataTable thongKePhieuMuonTheoNgay(string start, string end)
        {
            string sql = string.Format("select Loan_date as 'Ngày', count(BORROW_FORM.FORM_ID) as N'Số lượng phiếu mượn' from BORROW_FORM where Loan_date >='{0}' and loan_date <='{1}' group by LOAN_DATE",start,end);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }

        public DataTable thongKePhieuMuonTheoThang(string month,string year)
        {
            string sql = string.Format("select Loan_date as 'Ngày', count(BORROW_FORM.FORM_ID) as N'Số lượng phiếu mượn' from BORROW_FORM where month(Loan_date)='{0}' and year(loan_date)='{1}'  group by LOAN_DATE", month,year);
            var rs = ProcessData.LoadData(sql);
            return rs;
        }
    }
}
