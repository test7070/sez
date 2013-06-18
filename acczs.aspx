<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src="../script/qbox.js" type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        
        var q_name="acczs";
        var q_readonly = ['txtNoa'];
        var bbmNum = [['txtMount',10,0,1],['txtSale_money',14,0,1],['txtBuy_money',14,0,1],['txtDepl',14,0,1],['txtAccumulat',14,0,1],['txtC4',14,0,1],['txtC5',14,0,1]];
        var bbmMask =[];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        aPop = new Array(['txtAcczno', 'lblAcczno', 'accz', 'noa,namea,mount,money,accumulat', 'txtAcczno,txtNamea,txtMount,txtBuy_money,txtAccumulat', 'accz_b.aspx']);
		
		canSaleMount = 0;
		acczMoney = 0;
		accumulat = 0;
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy + "_" + r_cno)

        });

        //////////////////   end Ready
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }
            mainForm(0); // 1=Last  0=Top
        }  ///  end Main()


        function mainPost() { 
        	q_getFormat();
			bbmMask = [['txtSale_date', r_picd]];
            q_mask(bbmMask);
            $("input[id^='txt']").change(function(){
            	if($(this).attr('id') == 'txtMount'){
            		var Buy_money = 0;
            		if(dec($(this).val()) > canSaleMount){
            			if(emp($('#txtAcczno').val()))
            				alert('請輸入' + q_getMsg('lblAcczno'));
            			else
            				alert('出售數量大於可出售數量!!');
            			$(this).val(canSaleMount);
            			$('#txtBuy_money').val(acczMoney);
            		}else{
            			Buy_money = Math.round((dec(acczMoney)/dec(canSaleMount))*dec($(this).val()));
						$('#txtBuy_money').val(Buy_money);
						var t_where = "where=^^ noa='" +$('#txtAcczno').val() + "' ^^";
				        q_gt('acczt', t_where , 0, 1, 0, "", r_accy + '_' + r_cno);
	           		}
            	}
            	sum();
            });
        }
        
        function q_boxClose( s2) {
            var ret; 
            switch (b_pop) {
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
				case 'acczt':
                	var as = _q_appendData("acczt", "", true);
                	Before_Depl = 0; //前期折舊
                	This_Depl = 0; //本期折舊
                	for(var i = 0;i < as.length;i++){
                		if(as[i].mon != q_date().substring(0,6))
                			Before_Depl += dec(as[i].depl);
                		else
                			This_Depl = dec(as[i].depl);
                	}
                	Before_Depl += accumulat;
                	Before_Depl = Math.round((Before_Depl/canSaleMount)*dec($('#txtMount').val()));
                	This_Depl = Math.round((This_Depl/canSaleMount)*dec($('#txtMount').val()));
                	$('#txtDepl').val(dec(This_Depl));
                	$('#txtAccumulat').val(dec(Before_Depl));
                	sum();
                	break;
                case q_name: if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
		
		function q_popPost(s1) {
			switch (s1) {
				case 'txtAcczno':
					canSaleMount = dec($('#txtMount').val());
					acczMoney = dec($('#txtBuy_money').val());
					accumulat = dec($('#txtAccumulat').val());
					var t_where = "where=^^ noa='" +$('#txtAcczno').val() + "' ^^";
					q_gt('acczt', t_where , 0, 1, 0, "", r_accy + '_' + r_cno);
				break;
			}
		}   
		     
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('acczs_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
        }

        function btnIns() {
            _btnIns();
        	canSaleMount = 0;
			acczMoney = 0;
			accumulat = 0;
            $('#txtNoa').val('AUTO');
            $('#txtSale_date').val(q_date());
            $('#txtAcczno').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;

            _btnModi();
        	canSaleMount = 0;
			acczMoney = 0;
			accumulat = 0;
            $('#txtComp').focus();
        }

        function btnPrint() {
			q_box('z_acczs.aspx' + "?;;;;" + r_accy, '', '95%', '95%', q_getMsg("popPrint"));
        }
        
        function sum(){
        	//處分資產損益 = 沖銷成本 - 出售金額 - 提列折舊 - 沖銷累折
        	//total = buy_money - sale_money - depl - accumulat
        	var total = 0;
        	var buy_money = dec($('#txtBuy_money').val());
        	var sale_money = dec($('#txtSale_money').val());
        	var depl = dec($('#txtDepl').val());
        	var accumulat = dec($('#txtAccumulat').val());
			total = buy_money - sale_money - depl - accumulat;
			if(total < 0){
				$('#txtC4').val(Math.abs(total));
				$('#txtC5').val(0);
			}else{
				$('#txtC4').val(0);
				$('#txtC5').val(Math.abs(total));
			}
        }
        
        function btnOk() {
            var t_err = '';

            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')] ]);

            if( t_err.length > 0) {
                alert(t_err);
                return;
            }
            if (!emp($('#txtSale_date').val())&&checkId($('#txtSale_date').val())!=4){
                	alert(q_getMsg('lblSale_date')+'錯誤。');
                	return;
            }
            var t_noa = trim($('#txtNoa').val());

            if ( t_noa.length==0 || t_noa == "AUTO")  
                q_gtnoa(q_name, replaceAll(q_date(), '/', ''));
            else
                wrServer(  t_noa);
        }

        function wrServer( key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
        }
       
        function refresh(recno) {
        	canSaleMount = 0;
			acczMoney = 0;
			accumulat = 0;
            _refresh(recno);
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
        }

        function btnMinus(id) {
            _btnMinus(id);
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
        }

        function q_appendData(t_Table) {
            return _q_appendData(t_Table);
        }

        function btnSeek(){
            _btnSeek();
        }

        function btnTop() {
            _btnTop();
        }
        function btnPrev() {
            _btnPrev();
        }
        function btnPrevPage() {
            _btnPrevPage();
        }

        function btnNext() {
            _btnNext();
        }
        function btnNextPage() {
            _btnNextPage();
        }

        function btnBott() {
            _btnBott();
        }
        function q_brwAssign(s1) {
            _q_brwAssign(s1);
        }

        function btnDele() {
            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
        }
        function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }

    </script>
    <style type="text/css">
               #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 38%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 60%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewSale_date'></a></td>
                <td align="center" style="width:40%"><a id='vewNamea'></a></td>
                <td align="center" style="width:30%"><a id='vewNoa'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='sale_date'>~sale_date</td>
                   <td align="center" id='namea'>~namea</td>
                   <td align="center" id='noa'>~noa</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr>
               <td class="td1"><span> </span><a id="lblAcczno" class="lbl btn"></a></td>
               <td class="td2"><input id="txtAcczno"  type="text" class="txt c1" /></td>
               <td class="td3"><span> </span><a id="lblNamea" class="lbl"></a></td>
               <td class="td4"><input id="txtNamea"  type="text" class="txt c1" /></td>
               <td class="td5"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td6"><input id="txtNoa" type="text"  class="txt c1"/></td>             
            </tr> 
            <tr>
               <td class="td1"><span> </span><a id="lblSale_date" class="lbl"></a></td>
               <td class="td2"><input id="txtSale_date"  type="text" class="txt c1" /></td> 
               <td class="td3"><span> </span><a id='lblMount' class="lbl"></a></td>
               <td class="td4"><input id="txtMount" type="text" class="txt num c1" /></td>
               <td class="td5"><span> </span><a id="lblSale_money" class="lbl"></a></td>
               <td class="td6"><input id="txtSale_money"  type="text" class="txt num c1" /></td>
                            
            </tr>
            <tr>
               <td class="td1"><span> </span><a id="lblBuy_money" class="lbl"></a></td>
               <td class="td2"><input id="txtBuy_money"  type="text" class="txt num c1" /></td> 
               <td class="td3"><span> </span><a id='lblDepl' class="lbl"></a></td>
               <td class="td4"><input id="txtDepl"  type="text" class="txt num c1" /></td>
               <td class="td5"><span> </span><a id="lblAccumulat" class="lbl"></a></td>
               <td class="td6"><input id="txtAccumulat" type="text" class="txt num c1" /></td>
                        
            </tr>  
            <tr>
               <td class="td1"><span> </span><a id="lblC4" class="lbl"></a></td>
               <td class="td2"><input id="txtC4"  type="text" class="txt num c1" /></td>
               <td class="td3"><span> </span><a id="lblC5" class="lbl"></a></td>
               <td class="td4"><input id="txtC5"  type="text" class="txt num c1" /></td>
               <td class="td5"></td>
               <td class="td6"></td>              
            </tr>                                             
            <tr>
               <td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
               <td class="td2" colspan="5"><textarea id="txtMemo" rows="5" cols="10" style="width: 98%; height: 50px;"></textarea></td>               
            </tr>                                                                     
        </table>
        </div>
        </div>
         <input id="q_sys" type="hidden" />    
</body>
</html>
            