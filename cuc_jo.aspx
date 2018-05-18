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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "cuc";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
            var q_readonlys = ['txtWorkno'];
            var bbmNum = [];
            var bbsNum = [['txtRadius', 10, 3, 1], ['txtWidth', 10, 3, 1], ['txtDime', 10, 3, 1], ['txtLengthb', 10, 3, 1], ['txtHours', 10, 3, 1], ['txtMount', 10, 3, 1], ['txtWeight', 10, 3, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            brwCount2 = 6;
            aPop = new Array( ['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtCust_', 'cust_b.aspx']
            , ['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                bbsMask = [['txtDatea', r_picd], ['txtUdate', r_picd], ['txtDate2', r_picd]];
                q_mask(bbmMask);
                
                $('#btnOrdes').click(function() {
					var t_where = '';
					t_where = "isnull(a.enda,0)!=1 and isnull(a.cancel,0)!=1 and not exists(select * from view_cucs where a.noa=ordeno and a.no2=no2) ";
					q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "650px", q_getMsg('popOrde'));
				});
				
				$('#btnGenwork').click(function() {
					if (q_cur != 1 && q_cur != 2) {
						var worked = false;
						for (var i = 0; i < q_bbsCount; i++) {
							if (!emp($('#txtWorkno_' + i).val()))
								worked = true;
						}
						if (worked && t_gmount > 0)
							alert('製令單已領料-禁止重新產生製令單!!');
						else {
							q_func('cuc.genWork', r_accy + ',' + $('#txtNoa').val() + ',' + r_name);
							$('#btnGenwork').val('產生中...').attr('disabled', 'disabled');
						}
					}
				});
				
				$('#btnClose_div_ucagroup').click(function() {
					ucagroupdivmove = false;
					$('#div_ucagroup').hide();
				});
            }
            
            function q_funcPost(t_func, result) {
				if (t_func == 'cuc.genWork') {
					var workno = result.split(';')
					for (var j = 0; j < q_bbsCount; j++) {
						abbsNow[j]['workno'] = workno[j];
						$('#txtWorkno_' + j).val(workno[j]);
					}
					alert('製令產出執行完畢!!');
					$('#btnGenwork').val(q_getMsg('btnGenwork')).removeAttr('disabled');
				}
			}

            function q_popPost(s1) {
                switch(s1) {
                	
                }
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var ret;
                switch (b_pop) {
                	case 'ordes':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							for (var i=0;i<b_ret.length;i++){
								b_ret[i].uno='9999';
							}
							
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtCustno,txtCust,txtProductno,txtProduct,txtMount,txtUdate,txtUno', b_ret.length, b_ret
							, 'noa,no2,custno,comp,productno,product,mount,datea,uno', 'txtOrdeno,txtNo2,txtProductno,txtProduct');
						}
						break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }
			
			var t_works, t_gmount = 0;
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'view_works':
						t_gmount = 0;
						t_works = _q_appendData("view_works", "", true);
						for (var i = 0; i < t_works.length; i++) {
							t_gmount = t_gmount + dec(t_works[i].gmount);
						}
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                var t_date = trim($('#txtDatea').val());
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cuc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                //q_box('*.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                    	$('#btnBorn_' + j).click(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var t_ordeno = $.trim($('#txtOrdeno_'+n).val());
							var t_no2 = $.trim($('#txtNo2_'+n).val());
							
							if(t_ordeno.length > 0){
								var t_where = "noa='" + t_ordeno + "' and no2='" + t_no2 + "'";
								q_box("z_born.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'born', "95%", "95%", q_getMsg('lblBorn_s'));
							}
						});
                    	
                    	$('#btnDetails_' + j).click(function(e){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							$('#table_ucagroup .no').text('');
							$('#table_ucagroup .mon').text('');
							$('#table_ucagroup .memo1').text('');
							$('#table_ucagroup .memo2').text('');
							if(!emp($('#txtOrdeno_'+n).val()) && !emp($('#txtNo2_'+n).val())){
								var t_where = "where=^^ noa='"+$('#txtOrdeno_'+n).val()+"' and no2='"+$('#txtNo2_'+n).val()+"' ^^";
								q_gt('view_ordes', t_where, 0, 0, 0, "",r_accy,1);
								var ordeas = _q_appendData("view_ordes", "", true);
								if (ordeas[0] != undefined) {
									$('.ucano').text(ordeas[0].productno);
									var t_where = "where=^^ noa='"+ordeas[0].productno+"' ^^";
									q_gt('uca', t_where, 0, 0, 0, "",r_accy,1);
									var as = _q_appendData("uca", "", true);
									if (as[0] != undefined) {
										$('.ucaname').text(as[0].product);
										$('.ucaspec').text(as[0].spec);
										//車縫
										$('.groupe.no').text(as[0].groupeno);
										if(!emp($('.groupe.no').text())){
											var t_where = "where=^^ noa='"+$('.groupe.no').text()+"' ^^";
											q_gt('adsize', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adsize", "", true);
											if (ass[0] != undefined) {
												$('.groupe.mon').text(ass[0].mon);
												$('.groupe.memo1').text(ass[0].memo1);
												$('.groupe.memo2').text(ass[0].memo2);
											}
										}
										//車縫線顏色
										$('.ucolor.no').text(ordeas[0].ucolor);
										if(!emp($('.ucolor.no').text())){
											var t_where = "where=^^ noa='"+$('.ucolor.no').text()+"' ^^";
											q_gt('adspec', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adspec", "", true);
											if (ass[0] != undefined) {
												$('.ucolor.mon').text(ass[0].mon);
												$('.ucolor.memo1').text(ass[0].memo1);
												$('.ucolor.memo2').text(ass[0].memo2);
											}
										}
										//護片
										$('.groupf.no').text(as[0].groupfno);
										if(!emp($('.groupf.no').text())){
											var t_where = "where=^^ noa='"+$('.groupf.no').text()+"' ^^";
											q_gt('adsss', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adsss", "", true);
											if (ass[0] != undefined) {
												$('.groupf.mon').text(ass[0].mon);
												$('.groupf.memo1').text(ass[0].memo1);
												$('.groupf.memo2').text(ass[0].memo2);
											}
										}
										//皮料1
										$('.scolor.no').text(ordeas[0].scolor);
										if(!emp($('.scolor.no').text())){
											var t_where = "where=^^ noa='"+$('.scolor.no').text()+"' ^^";
											q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adly", "", true);
											if (ass[0] != undefined) {
												$('.scolor.mon').text(ass[0].mon);
												$('.scolor.memo1').text(ass[0].memo1);
												$('.scolor.memo2').text(ass[0].memo2);
											}
										}
										//皮料2
										$('.class.no').text(ordeas[0].class);
										if(!emp($('.class.no').text())){
											var t_where = "where=^^ noa='"+$('.class.no').text()+"' ^^";
											q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adly", "", true);
											if (ass[0] != undefined) {
												$('.class.mon').text(ass[0].mon);
												$('.class.memo1').text(ass[0].memo1);
												$('.class.memo2').text(ass[0].memo2);
											}
										}
										//皮料3
										$('.classa.no').text(ordeas[0].classa);
										if(!emp($('.classa.no').text())){
											var t_where = "where=^^ noa='"+$('.classa.no').text()+"' ^^";
											q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adly", "", true);
											if (ass[0] != undefined) {
												$('.classa.mon').text(ass[0].mon);
												$('.classa.memo1').text(ass[0].memo1);
												$('.classa.memo2').text(ass[0].memo2);
											}
										}
										//皮料4
										$('.zinc.no').text(ordeas[0].zinc);
										if(!emp($('.zinc.no').text())){
											var t_where = "where=^^ noa='"+$('.zinc.no').text()+"' ^^";
											q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adly", "", true);
											if (ass[0] != undefined) {
												$('.zinc.mon').text(ass[0].mon);
												$('.zinc.memo1').text(ass[0].memo1);
												$('.zinc.memo2').text(ass[0].memo2);
											}
										}
										//網烙印
										$('.sizea.no').text(ordeas[0].sizea);
										if(!emp($('.sizea.no').text())){
											var t_where = "where=^^ noa='"+$('.sizea.no').text()+"' ^^";
											q_gt('adoth', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adoth", "", true);
											if (ass[0] != undefined) {
												$('.sizea.mon').text(ass[0].mon);
												$('.sizea.memo1').text(ass[0].memo1);
												$('.sizea.memo2').text(ass[0].memo2);
											}
										}
										//轉印
										$('.source.no').text(ordeas[0].source);
										if(!emp($('.source.no').text())){
											var t_where = "where=^^ noa='"+$('.source.no').text()+"' ^^";
											q_gt('adpro', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adpro", "", true);
											if (ass[0] != undefined) {
												$('.source.mon').text(ass[0].mon);
												$('.source.memo1').text(ass[0].memo1);
												$('.source.memo2').text(ass[0].memo2);
											}
										}
										//大弓
										$('.groupg.no').text(as[0].groupgno);
										if(!emp($('.groupg.no').text())){
											var t_where = "where=^^ noa='"+$('.groupg.no').text()+"' ^^";
											q_gt('adknife', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adknife", "", true);
											if (ass[0] != undefined) {
												$('.groupg.mon').text(ass[0].mon);
												$('.groupg.memo1').text(ass[0].memo1);
												$('.groupg.memo2').text(ass[0].memo2);
											}
										}
										//中束
										$('.grouph.no').text(as[0].grouphno);
										if(!emp($('.grouph.no').text())){
											var t_where = "where=^^ noa='"+$('.grouph.no').text()+"' ^^";
											q_gt('adpipe', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adpipe", "", true);
											if (ass[0] != undefined) {
												$('.grouph.mon').text(ass[0].mon);
												$('.grouph.memo1').text(ass[0].memo1);
												$('.grouph.memo2').text(ass[0].memo2);
											}
										}
										//座管
										$('.groupi.no').text(as[0].groupino);
										if(!emp($('.groupi.no').text())){
											var t_where = "where=^^ noa='"+$('.groupi.no').text()+"' ^^";
											q_gt('adtran', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("adtran", "", true);
											if (ass[0] != undefined) {
												$('.groupi.mon').text(ass[0].mon);
												$('.groupi.memo1').text(ass[0].memo1);
												$('.groupi.memo2').text(ass[0].memo2);
											}
										}
										//電鍍
										$('.hard.no').text(ordeas[0].hard);
										if(!emp($('.hard.no').text())){
											var t_where = "where=^^ noa='"+$('.hard.no').text()+"' ^^";
											q_gt('addime', t_where, 0, 0, 0, "",r_accy,1);
											var ass = _q_appendData("addime", "", true);
											if (ass[0] != undefined) {
												$('.hard.mon').text(ass[0].mon);
												$('.hard.memo1').text(ass[0].memo1);
												$('.hard.memo2').text(ass[0].memo2);
											}
										}
										$('#div_ucagroup').css('top', e.pageY+30);
										$('#div_ucagroup').css('left', e.pageX- $('#div_ucagroup').width() -30);
										ucagroupdivmove = false;
										$('#div_ucagroup').show();
									}
								}
							}
						});
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date()).focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['datea'] && !as['ordeno'] && !as['no2'] && !as['productno']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();

                return true;
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
                var t_where = "where=^^ noa in (select noa from view_work where cuano='" + $('#txtNoa').val() + "') and isnull(gmount,0)>0 ^^";
				q_gt('view_works', t_where, 0, 0, 0, "", r_accy);
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
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            
            var ucagroupdivmove = false;
			function move(event){
 				if(ucagroupdivmove){
					var x = event.clientX-sx;
					var y = event.clientY-sy;
					sx = event.clientX;
					sy = event.clientY;
					$('#div_ucagroup').css('top', $('#div_ucagroup').offset().top+y);
					$('#div_ucagroup').css('left', $('#div_ucagroup').offset().left+x);
				}
			}

			function ucadivmove(event){
				if(!ucagroupdivmove){
					ucagroupdivmove = true; 
					sx = event.clientX;
					sy = event.clientY;
				}
				else if(ucagroupdivmove)
					ucagroupdivmove = false;
			}
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
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
                width: 75%;
                float: left;
            }
            .txt.c3 {
                width: 47%;
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
            .txt.c6 {
                width: 25%;
            }
            .txt.c7 {
                width: 95%;
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 1260px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbs {
                FONT-SIZE: medium;
                COLOR: blue;
                TEXT-ALIGN: left;
                BORDER: 1PX LIGHTGREY SOLID;
                width: 100%;
                height: 98%;
            }

            .tbbs .td1 {
                width: 8%;
            }
		</style>
	</head>
	<body  onmousemove="move(event);">
		<div id="div_ucagroup" style="position:absolute; top:300px; left:500px; display:none; width:680px; background-color: #FFE7CD; " onmousedown="ucadivmove(event);">
			<table id="table_ucagroup" class="table_row" style="width:100%;" cellpadding='1' cellspacing='0' border='1' >
				<tr>
					<td align="center"><a class="lbl">Item No.</a></td>
					<td align="left" colspan="4" class="ucano"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">Description</a></td>
					<td align="left" colspan="4" class="ucaname"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">型號</a></td>
					<td align="left" colspan="4" class="ucaspec"> </td>
				</tr>
				<tr>
					<td align="center" width="110px"><a class="lbl">要件</a></td>
					<td align="center" width="120px"><a class="lbl">編號</a></td>
					<td align="center" width="150px"><a class="lbl">中文</a></td>
					<td align="center" width="150px"><a class="lbl">英文</a></td>
					<td align="center" width="150px"><a class="lbl">越文</a></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">車縫 Đường may</a></td>
					<td align="center" class="groupe no"> </td>
					<td align="center" class="groupe mon"> </td>
					<td align="center" class="groupe memo1"> </td>
					<td align="center" class="groupe memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">車縫線顏色 Màu chỉ may</a></td>
					<td align="center" class="ucolor no"> </td>
					<td align="center" class="ucolor mon"> </td>
					<td align="center" class="ucolor memo1"> </td>
					<td align="center" class="ucolor memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">護片 Phụ kiện</a></td>
					<td align="center" class="groupf no"> </td>
					<td align="center" class="groupf mon"> </td>
					<td align="center" class="groupf memo1"> </td>
					<td align="center" class="groupf memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料1 Da1</a></td>
					<td align="center" class="scolor no"> </td>
					<td align="center" class="scolor mon"> </td>
					<td align="center" class="scolor memo1"> </td>
					<td align="center" class="scolor memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料2 Da2</a></td>
					<td align="center" class="class no"> </td>
					<td align="center" class="class mon"> </td>
					<td align="center" class="class memo1"> </td>
					<td align="center" class="class memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料3 Da3</a></td>
					<td align="center" class="classa no"> </td>
					<td align="center" class="classa mon"> </td>
					<td align="center" class="classa memo1"> </td>
					<td align="center" class="classa memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料4 Da4</a></td>
					<td align="center" class="zinc no"> </td>
					<td align="center" class="zinc mon"> </td>
					<td align="center" class="zinc memo1"> </td>
					<td align="center" class="zinc memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">網烙印 In ép</a></td>
					<td align="center" class="sizea no"> </td>
					<td align="center" class="sizea mon"> </td>
					<td align="center" class="sizea memo1"> </td>
					<td align="center" class="sizea memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">轉印 In ủi</a></td>
					<td align="center" class="source no"> </td>
					<td align="center" class="source mon"> </td>
					<td align="center" class="source memo1"> </td>
					<td align="center" class="source memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">大弓 Gọng</a></td>
					<td align="center" class="groupg no"> </td>
					<td align="center" class="groupg mon"> </td>
					<td align="center" class="groupg memo1"> </td>
					<td align="center" class="groupg memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">中束 Bông</a></td>
					<td align="center" class="grouph no"> </td>
					<td align="center" class="grouph mon"> </td>
					<td align="center" class="grouph memo1"> </td>
					<td align="center" class="grouph memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">座管 Ống yên</a></td>
					<td align="center" class="groupi no"> </td>
					<td align="center" class="groupi mon"> </td>
					<td align="center" class="groupi memo1"> </td>
					<td align="center" class="groupi memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">電鍍 mạ</a></td>
					<td align="center" class="hard no"> </td>
					<td align="center" class="hard mon"> </td>
					<td align="center" class="hard memo1"> </td>
					<td align="center" class="hard memo2"> </td>
				</tr>
				<tr>
					<td align="center" colspan='6'>
						<input id="btnClose_div_ucagroup" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left;  width:32%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewMech'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='mech'>~mech</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td style="text-align: center;"><input id='btnOrdes' type="button" style="float:none;"></td>
						<td style="text-align: center;"><input id='btnGenwork' type="button" style="float:none;"></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;'>
						<td align="center" style="width: 1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
						<td align="center" style="width:80px;"><a id='lblDatea_s'> </a></td>
						<td align="center" style="width:80px;"><a id='lblUno_s'> </a></td>
						<td align="center" style="width:80px"><a id='lblUdate_s'> </a></td>
						<!--<td align="center" style="width:80px;"><a id='lblDate2_s'> </a></td>-->
						<td align="center" style="width:150px;"><a id='lblOrdeno_s'> </a></td>
						<td align="center" style="width:130px;"><a id='lblCustno_s'> </a></td>
						<td align="center" style="width:130px"><a id='lblProductno_s'> </a></td>
						<td align="center" style="width:40px"><a id='lblDetails_s'>Details</a></td>
						<td align="center" style="width:85px;"><a id='lblMount_s'> </a></td>
						<td align="center" style="width:75px;"><a id='lblHours_s'> </a></td>
						<td align="center" style="width:125px;"><a id='lblWorkno_s'> </a></td>
						<td align="center" style="width:40px;"><a id='lblIsfreeze_s'> </a></td>
						<td align="center" style="width:40px;"><a id='lblBorn_s'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center"><input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
						<td><input class="txt c1" id="txtDatea.*" type="text"/></td>
						<td><input class="txt c1" id="txtUno.*" type="text"/></td>
						<td><input class="txt c1" id="txtUdate.*" type="text"/></td>
						<!--<td><input class="txt c1" id="txtDate2.*" type="text"/></td>-->
						<td>
							<input class="txt" id="txtOrdeno.*" type="text" style="width:65%;" />
							<input class="txt" id="txtNo2.*" type="text" style="width:25%;"/>
						</td>
						<td>
							<input class="txt" id="txtCustno.*" type="text" style="width:75%;" />
							<input class="btn" id="btnCustno.*" type="button" value="."/>
							<input class="txt c1" id="txtCust.*" type="text"/>
						</td>
						<td>
							<input class="txt" id="txtProductno.*" type="text" style="width:75%;" />
							<input class="btn" id="btnProductno.*" type="button" value="."/>
							<input class="txt c1" id="txtProduct.*" type="text"/>
						</td>
						<td align="center"><input class="btn" id="btnDetails.*" type="button" value='.' style=" font-weight: bold;" /></td>
						<td><input class="txt c1 num" id="txtMount.*" type="text"/></td>
						<td><input class="txt c1 num" id="txtHours.*" type="text"/></td>
						<td><input class="txt c1" id="txtWorkno.*" type="text"/></td>
						<td align="center"><input id="chkIsfreeze.*" type="checkbox"/></td>
						<td align="center"><input class="btn" id="btnBorn.*" type="button" value='.' style=" font-weight: bold;" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
