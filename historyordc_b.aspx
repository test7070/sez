<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = 'historyordc', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as;
            var t_sqlname = 'historyordc_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;
			brwCount2 = 0;
			brwCount = -1;			
            var decbbs = [];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if (location.href.indexOf('?') < 0)// debug
                {
                    // location.href = location.href + "?;;;noa='0015'";
                    // return;
                }
                if (!q_paraChk())
                    return;

                main();
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                q_gt('part', '', 0, 0, 0, "");
                mainBrow(6, t_content, t_sqlname, t_postname);
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
            }

            function bbsAssign() {/// 表身運算式
            	for (var j = 0; j < q_bbsCount; j++) {	
            		/*$('#cmbPartno_'+j).change(function() {
                	var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    	$(this).attr('size', len + "");
                	}).blur(function() {
                    	$(this).attr('size', '1');
                	});*/
				}
                _bbsAssign();
                for (var j = 0; j < q_bbsCount; j++) {
					if(abbs[j])
						$('#cmbPartno_'+j).val(abbs[j].partno);
				}
            }
			
			var maxnoq='000';
			var search_noq=false;
            function btnOk() {
                sum();

                t_key = q_getHref();
                if(!search_noq){
					q_gt('conn', "where=^^noa='"+t_key[1]+"'^^", 0, 0, 0, "conn_maxnoq");
					return;
				}
				
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#txtTypea_'+i).val($.trim(t_key[3]));
                	if(emp($('#txtNoq_'+i).val())){
                		maxnoq=('000'+(dec(maxnoq)+1)).substr(-3);
                		$('#txtNoq_'+i).val(maxnoq);
                	}
                }
                
                for (var i = 0; i < q_bbsCount; i++){
                	$('#txtPart_'+i).val($('#cmbPartno_'+i).find(":selected").text());
               	 }

                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
                
            }
			
            function bbsSave(as) {
                if (!as['namea'] && !as['tel'] && !as['addr'] && !as['mobile']) {
                    as[bbsKey[0]] = '';
                    return;
                }

                q_getId2('', as);

                return true;

            }

            function btnModi() {
                var t_key = q_getHref();

                if (!t_key)
                    return;

                _btnModi(1);

                for ( i = 0; i < abbsDele.length; i++) {
                    abbsDele[i][bbsKey[0]] = t_key[1];
                }
                $('#btnPlus').click();
                
            }

            function boxStore() {

            }

            function refresh() {
                //        refresh2();
                _refresh();
            }

            function sum() {
            }

            function q_gtPost(t_name) {  /// 資料下載後 ...
                switch (t_name) {
					case 'conn_maxnoq':
					var as = _q_appendData("conn", "", true);
					if (as[0] != undefined) {
						maxnoq=as[as.length-1].noq;
					}
					search_noq=true;
					btnOk();
					break;
				    case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            }
                            q_cmbParse("cmbPartno", t_item,"s");
                            _refresh();
                            for (var j = 0; j < q_bbsCount; j++) {
                            	if(abbs[j])
                            	$('#cmbPartno_'+j).val(abbs[j].partno);
                            }
                        }
                    break;
				}
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
                    bbsAssign();
                /// 表身運算式
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: 14px;'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:1%;"><a>輸入日期</a></td>
					<td align="center" style="width:1%;"><a>出貨類型</a></td>
					<td align="center" style="width:1%;"><a>說明</a></td>
					<td align="center" style="width:1%;"><a>運費</a></td>
					<td align="center" style="width:1%;"><a>板數/趟次</a></td>
					<td align="center" style="width:1%;"><a>件數/才數</a></td>
					<td align="center" style="width:1%;"><a>發送地</a></td>
					<td align="center" style="width:1%;"><a>到著地</a></td>
					<td align="center" style="width:1%;"><a>里程數</a></td>
					
				</tr>
				<tr  style='background:#cad3ff;font-size: 14px;'>
					<td >
						<input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold;"  />
						<input id="recno.*" type="hidden" />
					</td>
					<td style="width:6%;"><input class="txt"  id="txtNamea.*" type="text" style="width:98%;"  /></td>
					<td style="width:6%;"><input class="txt" id="txtJob.*" type="text" style="width:98%;"   /></td>
					<td style="width:6%;"><select id="cmbPartno.*" class="txt c1"> </select> <input class="txt" id="txtPart.*" type="text" style="display: none;"   /></td>
					<td style="width:10%;"><input class="txt" id="txtTel.*" type="text" style="width:94%;"  /></td>
					<td style="width:5%;"><input class="txt" id="txtExt.*" type="text" style="width:94%; text-align:right"  /></td>
					<td style="width:10%;"><input class="txt" id="txtFax.*" type="text" style="width:94%;"  /></td>
					<td style="width:10%;"><input class="txt" id="txtMobile.*" type="text" style="width:98%;"   /></td>
					<td style="width:12%;"><input class="txt" id="txtEmail.*" type="text" style="width:98%;"   /></td>
					<td style="width:20%;">
						<input class="txt" id="txtAddr.*" type="text" maxlength='90' style="width:98%;"  />
						<input id="txtNoq.*" type="hidden" />
						<input id="txtTypea.*" type="hidden" />
						
					</td>
					<td style="width:10%;"><input class="txt" id="txtMemo.*" type="text" style="width:98%;"  /></td>
					<td style="width:5%;"><input class="txt" id="chkBill.*" type="checkbox" style="width:94%;"/></td>
					
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
