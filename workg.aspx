<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
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
			this.errorHandler = null;
			q_tables = 't';
			var q_name = "workg";
			var q_readonly = ['txtNoa','txtFact', 'txtDatea', 'txtWorker', 'txtWorker2', 'txtOrdbno'];
			var q_readonlys = ['txtWorkno', 'txtIndate', 'txtInmount', 'txtWmount', 'txtOrdeno'];
			var q_readonlyt = [];
			var bbmNum = [];
			var bbsNum = [
				['txtOrdemount', 15, 0, 1], ['txtPlanmount', 15, 0, 1], ['txtStkmount', 15, 0, 1],
				['txtIntmount', 15, 0, 1], ['txtPurmount', 15, 0, 1], ['txtAvailmount', 15, 0, 1],
				['txtBornmount', 15, 0, 1], ['txtSalemount', 15, 0, 1], ['txtMount', 15, 0, 1],
				['txtInmount', 15, 0, 1], ['txtWmount', 15, 0, 1]
			];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			brwCount2 = 6;
			aPop = new Array(
				['txtFactno', 'lblFactno', 'factory', 'noa,factory', 'txtFactno,txtFact', 'factory_b.aspx'],
				['txtProductno', 'lblProduct', 'uca', 'noa,product', 'txtProductno,txtProduct', 'uca_b.aspx'],
				['txtProductno_', 'btnProduct_', 'uca', 'noa,product', 'txtProductno_,txtProduct_', 'uca_b.aspx'],
				['txtStationno_', 'btnStation_', 'station', 'noa,station', 'txtStationno_,txtStation_', 'station_b.aspx'],
				['txtProductno__', 'btnProduct__', 'uca', 'noa,product', 'txtProductno__,txtProduct__', 'uca_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtMon', r_picm]];
				bbsMask = [['txtRworkdate', r_picd], ['txtCuadate', r_picd], ['txtIndate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbStype", q_getPara('workg.stype'));

				$('#btnOrde').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						if (emp($('#txtBdate').val()) && emp($('#txtEdate').val())) {
							alert(q_getMsg('lblBdate') + '請先填寫。');
							return;
						}
						if ((!emp($('#txtBdate').val()) && emp($('#txtEdate').val())) || (emp($('#txtBdate').val()) && !emp($('#txtEdate').val()))) {
							alert(q_getMsg('lblBdate') + '錯誤!!。');
							return;
						}

						if (!emp($('#txtBdate').val()) && !emp($('#txtEdate').val())) {
							var t_where = "where=^^ ['" + q_date() + "','','') where productno=a.productno ^^";

							if (!emp($('#txtProductno').val()))
								var t_where1 = "where[1]=^^a.productno='" + $('#txtProductno').val() + "' and a.enda!='1' and (a.datea between '" + $('#txtBdate').val() + "' and '" + $('#txtEdate').val() + "') and a.productno in (select noa from uca) and charindex(a.noa+'-'+a.no2,isnull((select ordeno+',' from workgs" + r_accy + " FOR XML PATH('')),''))=0 group by productno ^^";
							else
								var t_where1 = "where[1]=^^a.enda!='1' and (a.datea between '" + $('#txtBdate').val() + "' and '" + $('#txtEdate').val() + "') and a.productno in (select noa from uca) and charindex(a.noa+'-'+a.no2,isnull((select ordeno+',' from workgs" + r_accy + " FOR XML PATH('')),''))=0 group by productno ^^";

							var t_where2 = "where[2]=^^e.enda!='1' and e.productno=a.productno and (e.datea between '" + $('#txtBdate').val() + "' and '" + $('#txtEdate').val() + "') and e.productno in (select noa from uca) and charindex(e.noa+'-'+e.no2,isnull((select ordeno+',' from workgs" + r_accy + " FOR XML PATH('')),''))=0 ^^";
							var t_where3 = "where[3]=^^ (c.datea between '" + $('#txtBdate').val() + "' and '" + $('#txtEdate').val() + "') and d.stype='4' and c.productno=a.productno and c.enda!='1' ^^"
							var t_where4 = "where[4]=^^ (c.datea < '" + $('#txtBdate').val() + "' and c.datea >= '" + q_date() + "') and c.productno=a.productno and c.enda!='1' ^^"
							q_gt('workg_orde', t_where + t_where1 + t_where2 + t_where3 + t_where4, 0, 0, 0, "", r_accy);
						}/*else if(!emp($('#txtMon').val())){
						 var t_where = "where=^^ ['"+q_date()+"','','') where productno=a.productno ^^";
						 if(!emp($('#txtProductno').val()))
						 var t_where1 = "where[1]=^^a.productno='"+$('#txtProductno').val()+"' and (b.odate between '"+$('#txtMon').val()+"/01' and '"+$('#txtMon').val()+"/31') and b.stype!='4' and a.productno in (select noa from uca) group by productno ^^";
						 else
						 var t_where1 = "where[1]=^^ (b.odate between '"+$('#txtMon').val()+"/01' and '"+$('#txtMon').val()+"/31') and b.stype!='4' and a.productno in (select noa from uca) group by productno ^^";
						 q_gt('workg_orde', t_where+t_where1, 0, 0, 0, "", r_accy);
						 }*/
					}
				});
				$('#btnWork').click(function() {
					if (q_cur != 1 && q_cur != 2) {
						var worked = false;
						for (var i = 0; i < q_bbsCount; i++) {
							if (!emp($('#txtWorkno_' + i).val()))
								worked = true;
						}
						if (worked && t_gmount > 0)
							alert('製令單已領料-禁止重新產生製令單!!');
						else {
							q_func('workg.genWork', r_accy + ',' + $('#txtNoa').val() + ',' + r_name);
							$('#btnWork').val('產生中...').attr('disabled', 'disabled');
						}
					}
				});
				//針對全部的物料需求
				/*$('#btnCuap').click(function(){
				q_box('z_cuap.aspx'+ "?;;;;"+r_accy+";", 'cup', "95%", "95%", q_getMsg("popPrint"));
				});*/
				//針對workg的物料需求
				$('#btnWorkg2ordb').click(function() {
					q_box('z_workg2ordb.aspx' + "?;;;;" + r_accy + ";", 'cup', "95%", "95%", q_getMsg("popPrint"));
				});

				$('#btnWorkPrint').click(function() {
					q_box('z_workp.aspx' + "?;;;noa='" + $('#txtNoa').val() + "';" + r_accy + ";", '', "95%", "95%", q_getMsg("popPrint"));
				});
				
				$('#lblOrdbno').click(function() {
					q_box('ordb.aspx' + "?;;;charindex(noa,'" + $('#txtOrdbno').val() + "')>0;" + r_accy + ";", '', "95%", "95%", q_getMsg("lblOrdbno"));
				});
			}

			var t_work, t_works, t_gmount = 0;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'work':
						t_gmount = 0;
						t_work = _q_appendData("work", "", true);
						t_works = _q_appendData("works", "", true);
						for (var i = 0; i < t_works.length; i++) {
							t_gmount = t_gmount + dec(t_works[i].gmount);
						}
						break;
					case 'workg_orde':
						var as = _q_appendData("view_ordes", "", true);
						var holiday = q_holiday;
						if (as[0] != undefined) {
							//清空bbs資料
							if (q_cur == 1) {
								for (var i = 0; i < q_bbsCount; i++) {
									$('#btnMinus_' + i).click();
								}
							}
							//計算//1030226將計畫生產移到後面
							for (var i = 0; i < as.length; i++) {
								var t_mount = 0;
								//t_mount=dec(as[i].unmount)+dec(as[i].ordemount)+dec(as[i].planmount)-dec(as[i].stkmount);
								t_mount = dec(as[i].stkmount) - dec(as[i].unmount) - dec(as[i].ordemount);
								as[i].availmount = t_mount;

								//if(t_mount<0) t_mount=0;

								//1030224由後端傳回，初值空白
								/*
								 //提前天數
								 var preday=0;
								 preday=preday+dec(as[i].pretime) //前置時間
								 //103/1/20 日產能=station.gen/uca.hours
								 if(dec(as[i].stationhours)*dec(as[i].stationgen)!=0)//103/1/20更正(數量*耗損率)/(工作中心產能/製成品需時)//(原)加上預計生產日數=(數量*需時*耗損率)/(工作中心工時*產能)
								 //preday=preday+Math.ceil((dec(t_mount)*dec(as[i].ucahours)*(1+dec(as[i].badperc)))/(dec(as[i].stationhours)*dec(as[i].stationgen)));
								 preday=preday+Math.ceil((dec(t_mount)*(1+dec(as[i].badperc)))/(dec(as[i].stationgen)/dec(as[i].ucahours)));

								 var t_date=emp(as[i].datea)?q_date():as[i].datea;//預交日
								 //跳過週休和假日
								 var six=q_getPara('sys.saturday');//週六休假,1有休0沒休
								 while(preday>0){
								 //轉換日期
								 var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
								 nextdate.setDate(nextdate.getDate() - 1);//日期往前1天
								 t_date=''+(nextdate.getFullYear()-1911)+'/';//年
								 t_date=t_date+((nextdate.getMonth()+1)<10?('0'+(nextdate.getMonth()+1)+'/'):((nextdate.getMonth()+1)+'/'));//月
								 t_date=t_date+(nextdate.getDate()<10?('0'+(nextdate.getDate())):(nextdate.getDate()));//日
								 if(six==1 && new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6) continue;//禮拜六
								 if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0) continue;//禮拜日
								 //假日
								 var isholiday=false;
								 for(var j=0;j<holiday.length;j++){
								 if(holiday[j]==t_date){
								 isholiday=true;
								 break;
								 }
								 }
								 if(isholiday) continue;

								 preday=preday-1;
								 }

								 as[i].rworkdate=t_date;
								 */
								as[i].rworkdate = '';
								as[i].ordeno = as[i].ordeno.substr(0, as[i].ordeno.length - 1);
							}
							q_gridAddRow(bbsHtm, 'tbbs', 'txtRworkdate,txtProductno,txtProduct,txtUnmount,txtOrdemount,txtPlanmount,txtStkmount,txtIntmount,txtPurmount,txtAvailmount,txtMount,txtOrdeno,txtStationno,txtStation', as.length, as, 'rworkdate,productno,product,unmount,ordemount,planmount,stkmount,inmount,purmount,availmount,bornmount,ordeno,stationno,station', 'txtProductno');
						} else {
							alert('無訂單資料!!。');
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if (t_name.substr(0, 9) == 'modiwork_') {
					var s_works = _q_appendData("works", "", true);
					var s_gmount = 0;
					for (var i = 0; i < s_works.length; i++) {
						s_gmount = s_gmount + dec(s_works[i].gmount);
					}
					if (s_gmount > 0) {
						t_noq = t_name.substr(t_name.indexOf('_') + 1, t_name.length)
						for (var j = 0; j < fbbs.length; j++) {
							$('#' + fbbs[j] + '_' + t_noq).attr('disabled', 'disabled');

						}
						$('#btnMinus_' + t_noq).attr('disabled', 'disabled');
					}
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('workg_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtBdate').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtBdate').focus();
				for (var i = 0; i < q_bbsCount; i++) {
					var t_where = "where=^^ cuano ='" + $('#txtNoa').val() + "' and cuanoq='" + $('#txtNoq_' + i).val() + "'^^";
					q_gt('work', t_where, 0, 0, 0, "modiwork_" + i, r_accy);
				}
			}

			function btnPrint() {
				q_box('z_workgp.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				sum();
				$('#txtWorker').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workg') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function bbtSave(as) {
				if (!as['uno']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				var t_where = "where=^^ cuano ='" + $('#txtNoa').val() + "' ^^";
				q_gt('work', t_where, 0, 0, 0, "", r_accy);
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

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtWorkno_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtWorkno_' + b_seq).val())) {
								t_where = "cuano='" + $('#txtNoa').val() + "' and cuanoq='" + $('#txtNoq_' + b_seq).val() + "'";
								q_box("work.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('PopWork'));
							}
						});
						$('#txtOrdeno_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtOrdeno_' + b_seq).val())) {
								t_where = " charindex(noa,'" + $('#txtOrdeno_' + b_seq).val() + "')>0 ";
								q_box("orde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('PopWork'));
							}
						});
						
						$('#btnScheduled_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtProductno_' + b_seq).val())) {
								t_where = "noa='"+$('#txtProductno_' + b_seq).val()+"' and product='"+$('#txtProduct_' + b_seq).val()+"' ";
								q_box("z_scheduled.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'scheduled', "95%", "95%", q_getMsg('PopScheduled'));
							}
						});

						$('#txtUnmount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtOrdemount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtPlanmount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtStkmount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtIntmount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtPurmount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtSalemount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#btnBorn_' + i).click(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var orde_deli = q_getPara('sys.key_orde');
							var thisOrdeno = $.trim($('#txtOrdeno_'+n).val());
							var t_ordeno = '';
							var t_no2 = '';
							if(thisOrdeno.length > 0){
								if(thisOrdeno.substring(0,orde_deli.length)==orde_deli){
									t_ordeno = thisOrdeno.substring(0,thisOrdeno.length-4);
									t_no2 = thisOrdeno.substr(t_ordeno.length+1);
									var t_where = "noa='" + t_ordeno + "' and no2='" + t_no2 + "'";
									q_box("z_born.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'born', "95%", "95%", q_getMsg('lblBorn'));
								}
							}else{
								var t_noa = $.trim($('#txtNoa').val());
								var t_noq = padL((dec(n)+1), '0', 3);
								var t_where = "workgnoa='" + t_noa + "' and workgnoq='" + t_noq + "'";
								q_box("z_born.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'born', "95%", "95%", q_getMsg('lblBorn'));
							}
						});
					}
				}
				_bbsAssign();
			}

			function bbssum(seq) {
				if (seq>-1) {
					//計算//1030226將計畫生產移到後面
					var t_availmount = q_float('txtStkmount_' + seq) - q_float('txtUnmount_' + seq) - q_float('txtOrdemount_' + seq);
					$('#txtAvailmount_' + seq).val(t_availmount);
					var t_opmount = t_availmount + q_float('txtIntmount_' + seq) + q_float('txtPurmount_' + seq) - q_float('txtSalemount_' + seq) - q_float('txtPlanmount_' + seq);

					if (t_opmount < 0)
						$('#txtMount_' + seq).val((t_opmount * -1));
					else
						$('#txtMount_' + seq).val(0);
					//沒有訂單號碼指定開工日寫入明天的日期
					if(emp($('#txtOrdeno_' + seq).val())&&q_float('txtMount_'+ seq)>0)
						$('#txtCuadate_' + seq).val(q_cdn(q_date(),1));
				}
			}

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
					}
				}
				_bbtAssign();
			}

			function sum() {
				for (var j = 0; j < q_bbsCount; j++) {

				}
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
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
				if (t_gmount > 0)
					alert('製令單已領料不能刪除!!');
				else
					_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			function q_popPost(id) {
				switch (id) {
					case 'txtProductno_':
						$('#txtClass_' + b_seq).focus();
						break;
					default:
						break;
				}
			}
			function q_funcPost(t_func, result) {
				if (t_func == 'workg.genWork') {
					var workno = result.split(';')
					for (var j = 0; j < q_bbsCount; j++) {
						abbsNow[j]['workno'] = workno[(j * 2) + 1];
						$('#txtWorkno_' + j).val(workno[(j * 2) + 1]);
						abbsNow[j]['rworkdate'] = workno[(j * 2) + 2];
						$('#txtRworkdate_' + j).val(workno[(j * 2) + 2]);
					}
					alert('製令產出執行完畢!!');
					$('#btnWork').val('製令產出').removeAttr('disabled');
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				border-width: 0px;
				width: 525px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
				width: 100%;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 735px;
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
				width: 1%;
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
				width: 99%;
				float: left;
			}
			.txt.c2 {
				width: 46%;
				float: left;
			}
			.txt.c3 {
				width: 35%;
				float: left;
			}
			.txt.c4 {
				width: 63%;
				float: left;
			}
			.num {
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
				font-size:medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs {
				width: 2700px;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: lightgrey;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			#dbbt {
				width: 800px;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: pink;
				width: 100%;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width: 1260px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:24px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:102px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:80px; color:black;"><a id='vewStype'> </a></td>
						<td style="color:black;"><a id='vewProduct'> </a></td>
						<td style="width:150px; color:black;"><a id='vewRang'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td align="center" id='stype=workg.stype'>~stype=workg.stype</td>
						<td id='product' style="text-align: center;">~product</td>
						<td id='bdate edate' style="text-align: center;">~bdate - ~edate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td><span> </span><a id="lblBdate" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtBdate" type="text" class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c2"/>
						</td>
						<!--<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtProductno" type="text" class="txt c3"/>
							<input id="txtProduct" type="text" class="txt c4"/>
						</td>
						<td><input id="btnOrde" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblFactno" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtFactno" type="text" class="txt c3"/>
							<input id="txtFact" type="text" class="txt c4"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="4"><input id="txtMemo" type="text" class="txt c1"/></td>
						<td><input id="btnWorkg2ordb" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdbno" class="lbl btn"> </a></td>
						<td colspan="4"><input id="txtOrdbno" type="text" class="txt c1"/></td>
						<td><input id="btnWorkPrint" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input id="btnWork" type="button"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:80px;"><a id='lblRworkdate_s'> </a></td>
						<td style="width:140px;"><a id='lblProductno_s'> </a></td>
						<td style="width:210px;"><a id='lblProduct_s'> </a></td>
						<td style="width:100px;"><a id='lblUnmount_s'> </a></td>
						<td style="width:100px;"><a id='lblOrdemount_s'> </a></td>
						<td style="width:80px;"><a id='lblStkmount_s'> </a></td>
						<td style="width:80px;"><a id='lblAvailmount_s'> </a></td>
						<td style="width:110px;"><a id='lblIntmount_s'> </a></td>
						<td style="width:80px;"><a id='lblPurmount_s'> </a></td>
						<!--<td style="width:80px;"><a id='lblBornmount_s'> </a></td>-->
						<td style="width:120px;"><a id='lblSalemount_s'> </a></td>
						<td style="width:100px;"><a id='lblPlanmount_s'> </a></td>
						<td style="width:100px;"><a id='lblMount_s'> </a></td>
						<td style="width:80px;"><a id='lblCuadate_s'> </a></td>
						<td style="width:250px;"><a id='lblStation_s'> </a></td>
						<td style="width:180px;"><a id='lblWorkno_s'> </a></td>
						<td style="width:50px;"><a id='lblRank_s'> </a></td>
						<td style="width:80px;"><a id='lblIndate_s'> </a></td>
						<td style="width:80px;"><a id='lblInmount_s'> </a></td>
						<td style="width:100px;"><a id='lblWmount_s'> </a></td>
						<td><a id='lblMemo_s'> </a></td>
						<td style="width:150px;"><a id='lblOrdeno_s'> </a></td>
						<td style="width:50px;"><a id='lblIsfreeze_s'> </a></td>
						<td style="width:40px;"><a id='lblBorn_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><input id="txtRworkdate.*" type="text" class="txt c1"/></td>
						<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
						<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
						<td><input id="txtUnmount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtOrdemount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtStkmount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtAvailmount.*" type="text" class="txt c1 num"/></td>
						<td>
							<input id="txtIntmount.*" type="text" class="txt c1 num" style="width: 80px;"/>
							<input class="btn" id="btnScheduled.*" type="button" value='.' style=" font-weight: bold;" />
						</td>
						<td><input id="txtPurmount.*" type="text" class="txt c1 num"/></td>
						<!--<td><input id="txtBornmount.*" type="text" class="txt c1 num"/></td>-->
						<td><input id="txtSalemount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtPlanmount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtCuadate.*" type="text" class="txt c1"/></td>
						<td>
							<input id="txtStationno.*" type="text" class="txt c1" style="width: 35%"/>
							<input id="btnStation.*" type="button" style="float:left;font-size: medium; font-weight: bold;" value="."/>
							<input id="txtStation.*" type="text" class="txt c1" style="width: 50%"/>
						</td>
						<td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
						<td><input id="txtRank.*" type="text" class="txt c1" style="text-align: center;"/></td>
						<td><input id="txtIndate.*" type="text" class="txt c1"/></td>
						<td><input id="txtInmount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtWmount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
						<td><input id="chkIsfreeze.*" type="checkbox"/></td>
						<td align="center">
							<input class="btn" id="btnBorn.*" type="button" value='.' style=" font-weight: bold;" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt'>
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"></td>
					<td style="width:160px; text-align: center;"><a id='lblOrdeno_t'> </a></td>
					<td style="width:40px; text-align: center;"><a id='lblNo2_t'> </a></td>
					<td style="width:120px; text-align: center;"><a id='lblProductno_t'> </a></td>
					<td style="width:180px; text-align: center;"><a id='lblProduct_t'> </a></td>
					<td style="width:100px; text-align: center;"><a id='lblSalemount_t'> </a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtOrdeno..*" type="text" class="txt c1"/></td>
					<td><input id="txtNo2..*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td><input id="txtProduct..*" type="text" class="txt c1"/></td>
					<td><input id="txtSalemount..*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>