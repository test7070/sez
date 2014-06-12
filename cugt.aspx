<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = 'cugt', t_bbsTag = 'tbbs', t_content = "", afilter = [] , bbmKey = [], bbsKey = ['noa,noq'], as, brwCount2 = 10;
            var t_sqlname = 'cugt_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = ['txtWeek','txtWorker'];
            var bbmNum = [];
            var bbsNum = [['txtGen', 10, 2, 1]];
            var bbmMask = [];
            var bbsMask = [['txtDatea', '999/99/99']];

            aPop = new Array();

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='0015'";
                    return;
                }
                if(!q_paraChk())
                    return;

                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
                q_mask(bbmMask);
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'view_cugt':
                		var as = _q_appendData("view_cugt", "", true);
                		if(as[0]!=undefined){
                			alert("該工作中心【"+$('#txtDatea_'+b_seq).val()+"】的排程產能已設定!!");
                			$('#btnMinus_'+b_seq).click();
                		}
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch

            }
            var tmpdate='';
            function bbsAssign() {
            	var t_stationno=q_getHref()[3];
            	var t_noa=q_getHref()[1];
            	for(var i = 0; i < q_bbsCount; i++) {
            		$('#txtDatea_' + i).focusin(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						tmpdate=$('#txtDatea_'+b_seq).val();
						
				    });
            		$('#txtDatea_' + i).blur(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						
						if(tmpdate!=$('#txtDatea_'+b_seq).val()){
							$('#txtWorker_'+b_seq).val(r_name);
							tmpdate='';
						}
						
						//資料空白不處理
						if(emp($('#txtDatea_'+b_seq).val()))
							return;
						//寫入星期
						$('#txtWeek_'+b_seq).val(getweek($('#txtDatea_'+b_seq).val()));
						
						//檢查輸入資料是否重複
						var isrepeat=false;
						for(var j = 0; j < q_bbsCount; j++) {
							if(b_seq!=j && $('#txtDatea_'+b_seq).val()==$('#txtDatea_'+j).val()){
								alert("該工作中心日期重複輸入!!");
								$('#btnMinus_'+b_seq).click();
								isrepeat=true;
								break;
							}
						}
						if(isrepeat)
							return;
						
						//檢查資料是否已存在DB
						q_gt('view_cugt',"where=^^noa!='"+t_noa+"' and stationno='"+t_stationno+"' and datea='"+$('#txtDatea_'+b_seq).val()+"' ^^", 0, 0, 0, "", r_accy);
				    });
				    
				    $('#txtGen_' + i).change(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						$('#txtWorker_'+b_seq).val(r_name);
				    });
				    
				    $('#txtMemo_' + i).change(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						$('#txtWorker_'+b_seq).val(r_name);
				    });
				    
				    $('#txtDatea_' + i).change(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						$('#txtWorker_'+b_seq).val(r_name);
						
						//資料空白不處理
						if(emp($('#txtDatea_'+b_seq).val()))
							return;
						//寫入星期
						$('#txtWeek_'+b_seq).val(getweek($('#txtDatea_'+b_seq).val()));
						
						//檢查輸入資料是否重複
						var isrepeat=false;
						for(var j = 0; j < q_bbsCount; j++) {
							if(b_seq!=j && $('#txtDatea_'+b_seq).val()==$('#txtDatea_'+j).val()){
								alert("該工作中心日期重複輸入!!");
								$('#btnMinus_'+b_seq).click();
								isrepeat=true;
								break;
							}
						}
						if(isrepeat)
							return;
						
						//檢查資料是否已存在DB
						q_gt('view_cugt',"where=^^noa!='"+t_noa+"' and stationno='"+t_stationno+"' and datea='"+$('#txtDatea_'+b_seq).val()+"' ^^", 0, 0, 0, "", r_accy);
				    });
            	}
                _bbsAssign();
                for(var i = 0; i < q_bbsCount; i++) {
                	if(!emp($('#txtDatea_'+i).val()))
                		$('#txtWeek_'+i).val(getweek($('#txtDatea_'+i).val()))
                		
                	$('#txtDatea_'+i).removeClass('hasDatepicker');
					$('#txtDatea_'+i).datepicker({defaultDate:$('#txtDatea_'+i).val()});
					
					$('#txtWeek_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
					$('#txtWorker_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
                }
            }
            
            function getweek(t_date) {
            	switch (new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()) {
            		case 0:
            			return '日'; 
            			break;
            		case 1:
            			return '一';
            			break;
            		case 2:
            			return '二';
            			break;
            		case 3:
            			return '三';
            			break;
            		case 4:
            			return '四';
            			break;
            		case 5:
            			return '五';
            			break;
            		case 6:
            			return '六';
            			break;
            		default:
            			return '';
  						break;
            	}
            }

            function btnOk() {
            	if(q_getHref()[0] == 'noa' && q_getHref()[1] != '' ){
	            	/*for(var i = 0 ;i < q_bbsCount;i++){
	            		
	            	}*/
            	}else{
            		alert("read error!");
            		return;
            	}
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
                
            }

            function bbsSave(as) {
                if(!as['datea']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
            }
            function refresh() {
                _refresh();
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if(q_tables == 's')
                    bbsAssign();
            }

		</script>
		<style type="text/css">
            td a {
                font-size: medium;
            }
            input[type="text"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:19%;"><a id='lblDatea'> </a></td>
					<td class="td3" align="center" style="width:8%;"><a id='lblWeek'> </a></td>
					<td class="td4" align="center" style="width:20%;"><a id='lblGen'> </a></td>
					<td class="td5" align="center" style="width:32%;"><a id='lblMemo'> </a></td>
					<td class="td6" align="center" style="width:20%;"><a id='lblWorker'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
						<input class="txt c1"  id="txtNoa.*" type="hidden"  />
	                    <input id="txtNoq.*" type="hidden" />
	                    <input id="txtStationno.*" type="hidden" />
					</td>
					<td class="td2"><input id="txtDatea.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="td3"><input id="txtWeek.*" type="text" class="txt c1" style="width:95%;text-align: center;"/></td>
					<td class="td4"><input id="txtGen.*" type="text" class="txt c1" style="width:95%;text-align: right;"/></td>
					<td class="td5"><input id="txtMemo.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="td6"><input id="txtWorker.*" type="text" class="txt c1" style="width:95%;"/></td>
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
