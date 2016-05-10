<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
    var q_name = 'tgg', t_content = ' field=noa,comp,nick,zip_invo,addr_invo,zip_home,addr_home,paytype', bbsKey = ['noa'], as, t_where = '';  // , afilter = ['noa', 'comp','nick']
    var isBott = false;  /// 是否已按過 最後一頁
    var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
    var i,s1;
        $(document).ready(function () {
            main();
        });         /// end ready

        function main() {
            if (dataErr)  /// 載入資料錯誤
            {
                dataErr = false;
                return;
            }
            mainBrow();
            $('#btnSearch').click(function() {
					var t_where="1=1";
					if(!emp($('#txtNoa').val())){
						t_where+=" and charindex('"+$('#txtNoa').val()+"',noa)>0";
					}
					if(!emp($('#txtComp').val())){
						t_where+=" and charindex('"+$('#txtComp').val()+"',comp)>0";
					}
					if(!emp($('#txtSerial').val())){
						t_where+=" and charindex('"+$('#txtSerial').val()+"',serial)>0";
					}
					for(var i=0; i<abbs.length; i++){
						if(abbs[i].sel==true || abbs[i].sel=="true"){
							t_noa=t_noa+(t_noa.length>0?',':'')+"'"+abbs[i].noa+"'"; 
						}
					}
					
					//t_where="where=^^"+t_where+"^^"
					location.href = "http://"+location.host +location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";"+t_where+";"+r_accy;
				});
         }


        function q_gtPost() { 
    
        }
        function refresh() {
            _refresh();
        }
    </script>
    <style type="text/css">
    </style>
</head>

<body> 
<div  id="dbbs"  >
       <table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
            <tr>
                <th align="center" > </th>
                <th align="center" style='color:Blue;' ><a id='lblNoa'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblComp'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblSerial'> </a></th>
            </tr>
            <tr>
                <td style="width:2%;"><input name="sel"  id="radSel.*" type="radio" /></td>
                <td style="width:20%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:60%;"><input class="txt" id="txtComp.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            	<td style="width:15%;"><input class="txt" id="txtSerial.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            </tr>
        </table>
        <div>
			<a>廠商編號</a>
			<input class="txt" id="txtNoa" type="text" style="width:130px;" />
			<a>廠商名稱 </a>
			 <input class="txt" id="txtComp" type="text" style="width:200px;" />
			 <BR>
			 <a>統一編號</a>
			 <input class="txt" id="txtSerial" type="text" style="width:200px;" />
			 <input type="button" id="btnSearch" style="border-style: none; width: 26px; height: 26px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;background-size: 100%;">
		 </div>
  <!--#include file="../inc/brow_ctrl.inc"--> 
</div>

</body>
</html> 

