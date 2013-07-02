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
        q_desc=1;
        q_tables = 's';
        var q_name = "workc";
        var decbbs = ['weight', 'mount'];
        var decbbm = ['mount', 'price'];
        var q_readonly = ['txtNoa','txtWorker'];
        var q_readonlys = ['txtWorkno'];
        var bbmNum = [];  // 允許 key 小數
        var bbsNum = [['txtMount', 15, 2,1],['txtWeight', 15, 2,1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'Datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
        aPop = new Array(
        	['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
        	['txtStoreno','lblStore','store','noa,store','txtStoreno,txtStore','store_b.aspx'],
        	['txtProcessno','lblProcess','process','noa,process','txtProcessno,txtProcess','process_b.aspx'],
        	['txtProductno', 'lblProductno', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx'],
        	['txtProcessno_','btnProcessno_','process','noa,process','txtProcessno_,txtProcess_','process_b.aspx'],
        	['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
        	['txtWorkno','lblWorkno','work','noa,processno,process,modelno,model,ordeno,no2,productno,product,tggno,comp,price',
        	'txtWorkno,txtProcessno,txtProcess,txtMoldno,txtMold,txtOrdeno,txtNo2,txtProductno,txtProduct,txtTggno,txtTgg,txtPrice','work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy]
        );
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_mask(bbmMask);
            q_brwCount();  // 計算 合適  brwCount
			q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
            
        });

        //////////////////   end Ready
       function main() {
           if (dataErr)  /// 載入資料錯誤
           {
               dataErr = false;
               return;
           }
            mainForm(1); // 1=最後一筆  0=第一筆   
        }
        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd], ['txtCuadate', r_picd]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('worka.typea'));   // 需在 main_form() 後執行，才會載入 系統參數
            $('#btnImportWorka').click(function(){
            	var t_workno = $.trim($('#txtWorkno').val());
            	if(!emp(t_workno)){
                	t_where = "workno='" + t_workno + "'";
                	q_box("workas_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workas', "95%", "95%", q_getMsg('popWorkas'));
            	}else{
            		alert('請輸入【' + q_getMsg('lblWorkno')+'】');
            	}
            });
            
            $('#txtWorkno').change(function(){
				var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
				q_gt('works', t_where , 0, 0, 0, "", r_accy);
			});
			$('#lblWorkno').click(function(){
				var t_where="enda!=1 "
				t_where += emp($('#txtWorkno').val())?'':" and charindex ('"+$('#txtWorkno').val()+"',noa)>0 ";
				t_where += emp($('#txtTggno').val())?'':" and charindex ('"+$('#txtTggno').val()+"',tggno)>0 ";
				q_box('work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";"+t_where+";" + r_accy, 'work', "95%", "95%", q_getMsg('popWork'));
			});
			$('#btnOrdes').click(function(){
				var t_where = "enda!=1";
                q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrdes'));
			});
		}

        function q_boxClose( s2) {
            var ret; 
            switch (b_pop ) {
            	case 'ordes':
                	if (q_cur > 0 && q_cur < 4) {
						b_ret = getb_ret();
						
						if (!b_ret || b_ret.length == 0)
							return;
						for (var i = 0; i < b_ret.length; i++) {
							var t_where = "where=^^ ordeno ='"+b_ret[i].noa+"' and no2='"+b_ret[i].no2+"' and tggno!=''^^";
							q_gt('works', t_where , 0, 0, 0, "", r_accy);
						}
					}
                break;
            	case 'work':
                	b_ret = getb_ret();
                	if(b_ret){
                		$('#txtWorkno').val(b_ret[0].noa);
                		$('#txtStationno').val(b_ret[0].stationno);
                		$('#txtStation').val(b_ret[0].station);
                		$('#txtProcessno').val(b_ret[0].processno);
                		$('#txtProcess').val(b_ret[0].process);
                		$('#txtModelno').val(b_ret[0].modelno);
                		$('#txtModel').val(b_ret[0].model);
                		$('#txtOrdeno').val(b_ret[0].ordeno);
                		$('#txtNo2').val(b_ret[0].no2);
                		$('#txtTggno').val(b_ret[0].tggno);
                		$('#txtTgg').val(b_ret[0].comp);

                		var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
						q_gt('works', t_where , 0, 0, 0, "", r_accy);
                	}
                break;
				case 'workas':
					if (q_cur > 0 && q_cur < 4) {
						b_ret = getb_ret();
						if (!b_ret || b_ret.length == 0)
							return;
						var i, j = 0;
						ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtTypea', b_ret.length, b_ret
														   , 'productno,product,unit,mount,typea'
														   , 'txtProductno');   /// 最後 aEmpField 不可以有【數字欄位】
						bbsAssign();
					}
					break;
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {
            switch (t_name) {
            	case 'works':
					//清空表身資料
            		for(var i = 0; i < q_bbsCount; i++) {
            			$('#btnMinus_'+i).click();
            		}
					var as = _q_appendData("works", "", true);
					for (i = 0; i < as.length; i++) {
							/*if(as[i].istd=='true'){
								as[i].productno=as[i].tproductno
								as[i].product=as[i].tproduct
							}*/
							
							if(as[i].unit.toUpperCase()=='KG'){
								as[i].xmount=0;
								as[i].xweight=as[i].mount;
							}else{
								as[i].xmount=as[i].mount;
								as[i].xweight=0;
							}
						}
					q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtWeight,txtMemo,txtProcessno,txtProcess,txtWorkno', as.length, as
														   , 'productno,product,unit,xmount,xweight,memo,processno,process,noa'
														   , '');   /// 最後 aEmpField 不可以有【數字欄位】
				 break;
                case q_name: 
                	if (q_cur == 4)
                        q_Seek_gtPost();
                    break;
            }
        }

        function btnOk() {
        	t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtTggno', q_getMsg('lblTgg')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();
            
			var t_date = $('#txtDatea').val();
            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
            q_box('workc_s.aspx', q_name + '_s', "510px", "330px", q_getMsg("popSeek"));
        }

        function bbsAssign() {  /// 表身運算式
            _bbsAssign();
            for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                $('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
            }
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
			q_box('z_workc.aspx'+ "?;;;noa="+trim($('#txtNoa').val())+";"+r_accy, '', "95%", "95%", m_print);
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
            as['custno'] = abbm2['custno'];
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j
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
					    q_gt('works', t_where , 0, 0, 0, "", r_accy);
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
            TEXT-ALIGN:  center;
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
        <div class="dview" id="dview" style="float: left;  width:30%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:4%"><a id='vewChk'></a></td>
                <td align="center" style="width:10%"><a id='vewDatea'></a></td>
                <td align="center" style="width:30%"><a id='vewNoa'></a></td>
                <!--<td align="center" style="width:55%"><a id='vewProduct'></a></td>-->
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <!--<td align="center" id='tggno tgg'>~tggno ~tgg</td>-->
                   <!--<td align="center" id='productno product'>~productno ~product</td>-->
            </tr>
        	</table>
        </div>
        <div class='dbbm' style="width: 70%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>

        <tr>
			<td><span> </span><a id='lblType' class="lbl"> </a></td>
			<td><select id="cmbTypea" class="txt c1"> </select></td>
        	<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
            <td><input id="txtDatea" type="text" class="txt c1"/></td>
        	<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
            <td><input id="txtNoa"   type="text"  class="txt c1"/></td> 
		</tr>
        <tr>
        	<td><span> </span><a id='lblStore' class="lbl btn"> </a></td>
            <td>
            	<input id="txtStoreno" type="text" class="txt c2"/>
            	<input id="txtStore" type="text" class="txt c2"/>
            </td> 
        	<td><span> </span><a id='lblCuadate' class="lbl"> </a></td>
            <td><input id="txtCuadate" type="text" class="txt c1"/></td>
            <td><span> </span><a id='lblMold' class="lbl"> </a></td>
        	<td>
        		<input id="txtMoldno" type="text" class="txt c2"/>
        		<input id="txtMold" type="text" class="txt c2"/>
        	</td>
		</tr>
        <!--<tr>
        	<td><span> </span><a id='lblProcess' class="lbl btn"> </a></td>
            <td>
            	<input id="txtProcessno" type="text"  class="txt c2"/>
            	<input id="txtProcess" type="text"  class="txt c2"/>
            </td>
        	<td><span> </span><a id='lblOrdeno' class="lbl"> </a></td>
            <td>
            	<input id="txtOrdeno" type="text" class="txt" style='width:70%;'/>
            	<input id="txtNo2" type="text" class="txt" style='width:20%;'/>
            </td>
        	<td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
            <td>
            	<input id="txtTggno" type="text" class="txt c2"/>
            	<input id="txtTgg" type="text"  class="txt c2"/>
            </td>
		</tr>-->
		<!--<tr>
			<td><span> </span><a id='lblWorkno' class="lbl btn"> </a></td>
            <td><input id="txtWorkno" type="text"  class="txt c1"/></td>
            <!--<td><span> </span><a id='lblProductno' class="lbl btn"> </a></td>
			<td><input id="txtProductno" type="text" class="txt c1"/></td>
			<!--<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
        	<td><input id="txtPrice" type="text" class="txt c1 num"/></td>
        </tr>-->
		<tr>
			<td></td>
			<td><input type="button" id="btnOrdes"></td>
        	<!--<td><span> </span><a id='lblProduct' class="lbl"> </a></td>
			<td colspan='3'><input id="txtProduct" type="text" style="width: 98%;"/></td>-->
        	<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
            <td><input id="txtWorker" type="text"  class="txt c1"/></td>
		</tr>
        <tr>
        	<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
	        <td colspan='5'><input id="txtMemo" type="text" style="width: 98%;"/></td>
		</tr>
        </table>
        </div>

        <div class='dbbs'>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td style="width:1%;" align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td style="width:13%;" align="center"><a id='lblProductnos'></a></td>
                <td style="width:15%;" align="center"><a id='lblProducts'></a></td>
                <td style="width:4%;" align="center"><a id='lblUnit'></a></td>
                <td style="width:10%;" align="center"><a id='lblMounts'></a></td>
                <td style="width:10%;" align="center"><a id='lblWeights'></a></td>
                <td style="width:15%;" align="center"><a id='lblProcesss'></a></td>
                <td style="width:10%;" align="center"><a id='lblTypes'></a></td>
                <td style="width:12%;" align="center"><a id='lblMemos'></a></td>
                <td style="width:10%;" align="center"><a id='lblWorknos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td>
                	<input class="txt" id="txtProductno.*" type="text" style="width:80%;" />
                	<input class="btn" id="btnProductno.*" type="button" value='...' style="width:12%;"  />
                </td>
                <td><input id="txtProduct.*" type="text" class="txt c1"/></td>
                <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                <td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
                <td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
                <td>
                	<input class="txt" id="txtProcessno.*" type="text" style="width:25%;" />
                	<input class="txt" id="txtProcess.*" type="text" style="width:60%;" />
                	<input class="btn" id="btnProcessno.*" type="button" value='.' style="width:1%;"  />
                </td>
                <td><input id="txtTypea.*" type="text" class="txt c1"/></td>
                <td><input id="txtMemo.*" type="text" class="txt c1"/>
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
                <td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
