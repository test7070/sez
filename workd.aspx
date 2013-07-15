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
        q_desc = 1;
        q_tables = 's';
        var q_name = "workd";
        var decbbs = ['weight', 'mount', 'gmount', 'emount', 'errmount', 'born'];
        var decbbm = ['mount', 'inmount', 'errmount', 'rmount', 'price', 'hours'];
        var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtTotal'];
        var q_readonlys = ['txtOrdeno', 'txtNo2', 'txtNoq','txtWorkno'];
        var bbmNum = [['txtMoney', 15,0,1],['txtTax', 15,0,1],['txtTotal', 15,0,1]];  // 允許 key 小數
        var bbsNum = [['txtBorn', 15,2,1],['txtMount', 15,2,1],['txtPrice', 15,2,1],['txtTotal', 15,0,1],['txtErrmount', 15,2,1],['txtWmount', 15, 2, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = '';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
        aPop = new Array(
        	['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
        	['txtStoreno','lblStore','store','noa,store','txtStoreno,txtStore','store_b.aspx'],
        	['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
        	['txtWorkno','lblWorkno','work','noa,productno,product,tggno,comp','txtWorkno,txtProductno,txtProduct,txtTggno,txtTgg,','work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy]
        );

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  // 計算 合適  brwCount 
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy); /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
        });

        //////////////////   end Ready
       function main() {
           if (dataErr)  /// 載入資料錯誤
           {
               dataErr = false;
               return;
           }
            mainForm(1); // 1=最後一筆  0=第一筆
        }  ///  end Main()

        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            $('#btnImportWorkc').click(function(){
            	var t_tggno = $.trim($('#txtTggno').val());
            	var t_workcno = $.trim($('#txtWorkcno').val());
            	var t_where = "where=^^ tggno='"+t_tggno+"'";
            	if(!emp(t_tggno.length)){
            		if(!emp(t_workcno.length))
            			t_where = " workcno='"+t_workcno+"'";
                	t_where += " ^^";
                	q_gt('view_workcs', t_where, 0, 0, 0, "", r_accy);
               	}else{
               		alert('請輸入【'+q_getMsg('lblTgg')+'】');
               	}
            });
            
            $('#txtWorkno').change(function(){
				var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
				q_gt('work', t_where , 0, 0, 0, "", r_accy);
			});
			
			$('#lblWorkno').click(function(){
				var t_where="enda!=1 "
				t_where += emp($('#txtWorkno').val())?'':" and charindex ('"+$('#txtWorkno').val()+"',noa)>0 ";
				t_where += emp($('#txtTggno').val())?'':" and charindex ('"+$('#txtTggno').val()+"',tggno)>0 ";
				q_box('work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";"+t_where+";" + r_accy, 'work', "95%", "95%", q_getMsg('popWork'));
			});
			$('#btnOrdes').click(function(){
				if(q_cur==1 || q_cur==2){
					var t_where = "enda!=1";
	                q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrdes'));
               }
			});
			$('#txtMoney').change(function(){sum();});
			$('#txtTax').change(function(){sum();});
        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret; 
            switch (b_pop ) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
            	case 'ordes':
                	if (q_cur > 0 && q_cur < 4) {
						b_ret = getb_ret();
						
						if (!b_ret || b_ret.length == 0)
							return;
						for (var i = 0; i < b_ret.length; i++) {
							var t_where = "where=^^ ordeno ='"+b_ret[i].noa+"' and no2='"+b_ret[i].no2+"' and tggno!='' and left(tggno,1)!='Z' ";
							if(!emp($('#txtTggno').val()))
								t_where+=" and tggno='"+$('#txtTggno').val()+"'";
							
							t_where+="^^";
							q_gt('work', t_where , 0, 0, 0, "", r_accy);
						}
					}
				 break;
            	case 'work':
                	b_ret = getb_ret();
                	if(b_ret){
                		$('#txtWorkno').val(b_ret[0].noa);
                		var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
						q_gt('work', t_where , 0, 0, 0, "", r_accy);
                	}
                break;
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
            	case 'work':
            		//清空表身資料
            		for(var i = 0; i < q_bbsCount; i++) {
            			$('#btnMinus_'+i).click();
            		}
            		
					var as = _q_appendData("work", "", true);
					for (i = 0; i < as.length; i++) {
							
							if(as[i].unit.toUpperCase()=='KG'){
								as[i].xmount=0;
								as[i].xweight=as[i].mount;
							}else{
								as[i].xmount=as[i].mount;
								as[i].xweight=0;
							}
						}
					q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtWeight,txtBorn,txtBweight,txtOrdeno,txtNo2,txtMemo,txtPrice,txtWorkno', as.length, as
														   , 'productno,product,unit,xmount,xweight,xmount,xweight,ordeno,no2,memo,price,noa'
														   , '');   /// 最後 aEmpField 不可以有【數字欄位】
					sum();
				 break;
				case 'view_workcs':
					var as = _q_appendData("view_workcs", "", true);
					if(as[0]!=undefined){
						q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtBorn,txtPrice,txtOrdeno,txtNo2,txtMemo'
								, as.length, as, 'productno,product,unit,mount,price,ordeno,no2,memo', 'txtProductno');
						$('#txtWorkcno').val(as[0].noa);
						sum();
					}
					
					break;
                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
        	t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtTggno', q_getMsg('lblTgg')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

			if(q_cur==1)
				$('#txtWorker').val(r_name);
			else
            	$('#txtWorker2').val(r_name);
            sum();
			var t_date = $('#txtDatea').val();
            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workd') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
            q_box('workd_s.aspx', q_name + '_s', "510px", "380px", q_getMsg("popSeek"));
        }

        function bbsAssign() {  /// 表身運算式
            _bbsAssign();
            for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                $('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
                $('#txtMount_' + j).change(function(){sum();});
                $('#txtPrice_' + j).change(function(){sum();});
                $('#txtTotal_' + j).change(function(){sum();});
            } //j
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();

         }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
        }
        function btnPrint() {
			q_box('z_workd.aspx'+ "?;;;noa="+trim($('#txtNoa').val())+";"+r_accy, '', "95%", "95%", m_print);
        }

        function wrServer( key_value) {
            var i;
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product'] ) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
            as['datea'] = abbm2['datea'];
            return true;
        }

        function sum() {
            var t_mount = 0;t_price = 0;
            for (var j = 0; j < q_bbsCount; j++) {
				t_mount = dec($('#txtMount_' + j).val());
				t_weight = dec($('#txtWeight_' + j).val());
				t_price = dec($('#txtPrice_' + j).val());
				if($('#txtUnit_' + j).val().toUpperCase()!='KG') 
					$('#txtTotal_' + j).val(round(t_mount*t_price,0));
				else
					$('#txtTotal_' + j).val(round(t_weight*t_price,0));
            }  // j
            var m_Money = dec($('#txtMoney').val());
			var m_Tax = dec($('#txtTax').val());
			$('#txtTotal').val(m_Money + m_Tax);
			$('#txtTotal').focusout();
        }
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
        }

        function btnMinus(id) {
            _btnMinus(id);
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            if (q_tables == 's')
                bbsAssign();  /// 表身運算式 
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
        function q_popPost(s1) {
			switch (s1) {
				case 'txtWorkno':
					var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
					q_gt('work', t_where , 0, 0, 0, "", r_accy);
				break;
			}
		}
    </script>
    <style type="text/css">
        .tview
        {
            FONT-SIZE: 12pt;
            COLOR:  Blue ;
            background:#FFCC00;
            padding: 3px;
            TEXT-ALIGN:  center
        }    
        .tbbm
        {
            FONT-SIZE: 12pt;
            COLOR: blue;
            TEXT-ALIGN: left;
            border-color: white; 
            width:98%; border-collapse: collapse; background:#cad3ff;
        } 
        
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:98% ; height:98% ;  
        } 
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
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
			.txt {
				float: left;
			}
            .txt.c1 {
                width: 95%;
            }
            .txt.c2 {
                width: 46%;
            }
			.num{
				text-align: right;
			}      
			input[type="text"],input[type="button"] {     
				font-size: medium;
			}
</style>
</head>
<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
>
<!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:18%"><a id='vewDatea'></a></td>
                <!--<td align="center" style="width:30%"><a id='vewTgg'></a></td>-->
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <!--<td align="center" id='tggno tgg,4'>~tggno ~tgg,4</td>-->
                   <td align="center" id='noa'>~noa</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
	        <tr>
	        	<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
	        	<td><input id="txtDatea" type="text" class="txt c1"/></td>
	        	<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
	            <td><input id="txtNoa" type="text" class="txt c1"/></td>
	            <td> </td>
			</tr>
	        <tr>
	        	<td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
	            <td>
	            	<input id="txtTggno" type="text" class="txt" style='width:45%;'/>
	            	<input id="txtTgg" type="text" class="txt"  style='width:48%;'/>
	            </td>
	        	<td><span> </span><a id='lblStore' class="lbl btn"> </a></td>
	            <td>
	            	<input id="txtStoreno" type="text" class="txt" style='width:45%;'/>
	            	<input id="txtStore" type="text" class="txt" style='width:48%;'/>
	            </td> 
			</tr>
	        <tr>        
				<td><span> </span><a id='lblWorkcno' class="lbl"> </a></td>
	            <td><input id="txtWorkcno" type="text" class="txt c1"/></td>
				<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
	            <td><input id="txtInvono" type="text" class="txt c1"/></td>
			</tr>
	        <tr>        
				<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
	            <td><input id="txtMoney" type="text" class="txt c1 num"/></td>
				<td><span> </span><a id='lblTax' class="lbl"> </a></td>
	            <td><input id="txtTax" type="text" class="txt c1 num"/></td>
			</tr>
	        <tr>        
				<td></td>
	            <td></td>
				<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
	            <td><input id="txtTotal" type="text" class="txt c1 num"/></td>
			</tr>
			<tr>
				<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
	            <td><input id="txtWorker" type="text" class="txt c1"/></td>
				<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
	            <td><input id="txtWorker2" type="text" class="txt c1"/></td>
			</tr>
	        <tr>
	        	<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
	        	<td colspan='2'><input id="txtMemo" type="text" class="txt c1"/></td>
				<td><input type="button" id="btnOrdes"></td>
	        </tr>
        </table>
        </div>

        <div class='dbbs'>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'>
            <tr style='color:White; background:#003366;' >
                <td style="width:1%;" align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td style="width:10%;" align="center"><a id='lblProductnos'></a></td>
                <td style="width:13%;" align="center"><a id='lblProduct_s'></a></td>
                <td style="width:5%;" align="center"><a id='lblUnit'></a></td>
                <!--<td style="width:7%;" align="center"><a id='lblBorn'></a></td>-->
                <td style="width:7%;" align="center"><a id='lblMounts'></a></td>
                <td style="width:7%;" align="center"><a id='lblWmounts'></a></td>
                <td style="width:7%;" align="center"><a id='lblPrice_s'></a></td>
                <td style="width:8%;" align="center"><a id='lblTotal_s'></a></td>
                <td style="width:10%;" align="center"><a id='lblErrmount'></a></td>
                <td style="width:13%;" align="center"><a id='lblMemos'></a></td>
                <td style="width:10%;" align="center"><a id='lblWorknos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'><!--1020702製造業通常只用到數量，所以重量隱藏，並將生產數量改為報廢數量-->
                <td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td>
                	<input class="txt" id="txtProductno.*" type="text" style="width:80%;" />
                	<input class="btn" id="btnProductno.*" type="button" value='.' style="width:16%;"  />
                </td>
                <td><input class="txt c1" id="txtProduct.*" type="text"/></td>
                <td><input class="txt c1" id="txtUnit.*" type="text"/></td>
                <!--<td><input class="txt c1 num" id="txtBorn.*" type="text"/>
                	<input class="txt c1 num" id="txtBweight.*" type="text"/>
                </td>-->
                <td><input class="txt c1 num" id="txtMount.*" type="text"/>
                	<!--<input class="txt c1 num" id="txtWeight.*" type="text"/>-->
                </td>
                <td><input class="txt c1 num" id="txtWmount.*" type="text"/>
                </td>
                <td><input class="txt c1 num" id="txtPrice.*" type="text"/></td>
                <td><input class="txt c1 num" id="txtTotal.*" type="text"/></td>
                <td>
                	<input class="txt c1 num" id="txtErrmount.*" type="text"/>
                	<input class="txt c1" id="txtErrmemo.*" type="text"/>
                </td>
                <td>
                	<input class="txt c1" id="txtMemo.*" type="text"/>
	                <input class="txt" id="txtOrdeno.*" type="text" style="width:70%;"/>
	                <input class="txt" id="txtNo2.*" type="text" style="width:20%;"/>
	                <input id="txtNoq.*" type="hidden" />
	                <input id="recno.*" type="hidden" />
				</td>
				<td>
					<input id="txtWorkno.*" type="text" class="txt c1"/>
				</td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>