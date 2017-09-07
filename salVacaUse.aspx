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

            var q_name = "salvacause";
            var q_readonly = ['txtNoa', 'txtHr_special', 'txtTot_special', 'txtJob','txtNamea','txtHname','txtPart','txtId','txtPartno','txtDatea'];
            var bbmNum = [['txtHr_used', 10, 1, 1], ['txtHr_special', 10, 1, 1], ['txtTot_special', 10, 1, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea,partno,part,job,jobno', 'txtSssno,txtNamea,txtPartno,txtPart,txtJob,txtJobno', 'sss_b.aspx']
            , ['txtHtype', 'lblHtype', 'salhtype', 'noa,namea', 'txtHtype,txtHname', 'salhtype_b.aspx']
            ,['txtAgent', '', 'sss', 'noa,namea', '0txtAgent,txtAgent', '']
            );
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                //q_gt(q_name, q_content, q_sqlCount, 1)
                //$('#txtNoa').focus
               if (r_rank < 8 && q_content==''){
					q_gt('sss', "where=^^noa='" + r_userno + "'^^", 0, 1);
                }else{
                    q_gt(q_name, q_content, q_sqlCount, 1);
				}
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }///  end Main()

            var t_tot_special = 0;
            //存放初始'特休假剩餘天數'
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtBtime', '99:99'], ['txtEtime', '99:99']];
                q_mask(bbmMask);
                
                //讀取假日主檔
				q_gt('holiday', "where=^^ noa>='"+q_date().substr(0,r_len)+"' ^^", 0, 0, 0,"", r_accy);
                
                $('#txtSssno').change(function() {
                    if (!emp($('#txtSssno').val())) {
                        //找員工的特休假可用天數和特休假剩餘天數
                        var t_where = "where=^^ noa ='" + $('#txtBdate').val().substr(0, 3) + "' ^^";
                        q_gt('salvaca', t_where, 0, 0, 0, "", r_accy);
                        
                    }
				});

                $('#txtBdate').focus(function() {
                    q_msg($(this), '請假日期跨月份，請申請兩張!!');
                }).blur(function() {
                    if ($('#txtBdate').val().substr(0, 6) != $('#txtEdate').val().substr(0, 6) || $('#txtBdate').val() > $('#txtEdate').val()) {
                        //alert('請假日期不正確!!');
                        $('#txtEdate').val($('#txtBdate').val());
                    }
                    q_msg();
                    
                    if (!emp($('#txtSssno').val())) {
                        //找員工的特休假可用天數和特休假剩餘天數
                        var t_where = "where=^^ noa ='" + $('#txtBdate').val().substr(0, 3) + "' ^^";
                        q_gt('salvaca', t_where, 0, 0, 0, "", r_accy);
                    }
                    change_hr_used();
                });

                $('#txtEdate').focus(function() {
                    q_msg($(this), '請假日期跨月份，請申請兩張!!'); //處理薪資
                }).blur(function() {
                    if ($('#txtBdate').val().substr(0, r_lenm) != $('#txtEdate').val().substr(0, r_lenm) || $('#txtBdate').val() > $('#txtEdate').val()) {
                        alert('請假日期不正確!!');
                        $('#txtEdate').val($('#txtBdate').val());
                    }
                    q_msg();
                    change_hr_used();
                });

                $('#txtBtime').blur(function() {
                	if(q_getPara('sys.project').toUpperCase()=='DC'){
                    	//105/10/11 只能請XX:00 或XX:30
                    	if(!emp($('#txtBtime').val()) && ($('#txtBtime').val().slice(-2)!='00' && $('#txtBtime').val().slice(-2)!='30')){
                    		if($('#txtBtime').val().slice(-2)>='30'){
                    			$('#txtBtime').val($('#txtBtime').val().substr(0,3)+'30');
                    		}else{
                    			$('#txtBtime').val($('#txtBtime').val().substr(0,3)+'00');
                    		}
                    	}
                    }
                    change_hr_used();
                });

                $('#txtEtime').blur(function() {
                	if(q_getPara('sys.project').toUpperCase()=='DC'){
                    	//105/10/11 只能請XX:00 或XX:30
                    	if(!emp($('#txtEtime').val()) && ($('#txtEtime').val().slice(-2)!='00' && $('#txtEtime').val().slice(-2)!='30')){
                    		if($('#txtEtime').val().slice(-2)>='30'){
                    			$('#txtEtime').val($('#txtEtime').val().substr(0,3)+'30');
                    		}else{
                    			$('#txtEtime').val($('#txtEtime').val().substr(0,3)+'00');
                    		}
                    	}
                    }
                    change_hr_used();
                });

                $('#txtHr_used').change(function() {
                    if (emp($('#txtSssno').val())) {
                        alert('請先填寫員工編號!!');
                        $('#txtHr_used').val('0');
                        return;
                    }
                    if (emp($('#txtHtype').val())) {
                        alert('請先填寫假別!!');
                        $('#txtHr_used').val('0');
                        return;
                    }
                    if ($('#txtHname').val().indexOf('特休') > -1)
                        q_tr('txtTot_special', t_tot_special - q_float('txtHr_used'));
                        
                    if ($('#txtHname').val().indexOf('抵工時') > -1)
                    	$("#btnCarryforwards").removeAttr("disabled");
                });

                $('#lblAgent').click(function() {
                    q_box("sss_b2.aspx", 'sss', "450px", "700px", $('#lblAgent').text());
                });
                
                if(q_getPara('sys.project').toUpperCase()=='NV'){
                	$('#btnCarryforwards').show();
                }
				$('#btnCarryforwards').click(function() {
					var t_err = '';
					t_err = q_chkEmpField([['txtSssno', q_getMsg('lblSss')], ['txtBdate', q_getMsg('lblBdate')], ['txtHr_used', q_getMsg('lblHr_used')]]);
					if (t_err.length > 0) {
						alert(t_err);
						return;
					}
					/*if(dec($('#txtHr_used').val())<=0){
						alert('請先輸入請假時數!!');
						return;
					}*/
					
					var t_carryforwards=dec(q_getPara('salvacause.carryforwards'));//換休期限
					
					if(q_getPara('sys.project').toUpperCase()=='NV'){
						var t_where="sssno='"+$('#txtSssno').val()+"' and exists (select datea from dbo.carryforwards("+t_carryforwards+",'"+$('#txtSssno').val()+"','"+$('#txtNoa').val()+"') where ('"+$('#txtEdate').val()+"' between datea and enddate) and special-used!=0 and datea=saladd.datea)";
						q_box("saladd_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where , 'salpresents', "600px", "95%", $('#btnCarryforwards').val());
					}else{
						var t_where="sssno='"+$('#txtSssno').val()+"' and exists (select datea from dbo.carryforwards("+t_carryforwards+",'"+$('#txtSssno').val()+"','"+$('#txtNoa').val()+"') where ('"+$('#txtEdate').val()+"' between datea and enddate) and special-used!=0 and datea=salpresents.noa)";
						q_box("salpresents_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where , 'salpresents', "600px", "95%", $('#btnCarryforwards').val());
					}
				});
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'sss':
                        ret = getb_ret();
                        if (q_cur > 0 && q_cur < 4) {
                            if (ret[0] != undefined) {
                                for (var i = 0; i < ret.length; i++) {
                                    if ($('#txtAgent').val().length > 0) {
                                        var temp = $('#txtAgent').val();
                                        $('#txtAgent').val(temp + ',' + ret[i].namea);
                                    } else {
                                        $('#txtAgent').val(ret[i].namea);
                                    }
                                }
                            }
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            var ssspartno = '',sssgroup='',sssjob='';
            var holidayas;
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'authority':
                        var as = _q_appendData('authority', '', true);
                        if (as[0] != undefined) {
                        	if(q_getPara('sys.project').toUpperCase()=='DC'){ //105/10/28 040136調整
	                            if (r_rank >= 7 || r_userno=='020110' || r_userno=='040136') //104/03/24 職務變動姮瑜可以看到全部的資料
	                                q_content = "";
	                            else if (as.length > 0 && as[0]["pr_modi"] == "true")
	                                q_content = "where=^^partno='" + ssspartno + "'^^";
	                            else
	                                q_content = "where=^^sssno='" + r_userno + "'^^";
							}else{
								if (r_rank >= 8)
	                                q_content = "";
	                            else
	                                q_content = "where=^^sssno='" + r_userno + "'^^";
							}
                        }
                        q_gt(q_name, q_content, q_sqlCount, 1)
                        break;
                    case 'holiday':
						holidayas = _q_appendData('holiday', '', true);
						break;
                    case 'sss':
                        var as = _q_appendData('sss', '', true);
                        if (as[0] != undefined) {
                            ssspartno = as[0].partno;
                            sssjob=as[0].job;
	                        q_gt('authority', "where=^^a.noa='salvacause' and a.sssno='" + r_userno + "'^^", q_sqlCount, 1);
                        }
                        break;
                    case 'salvaca':
                        if (q_cur == 1 || q_cur==2) {
                            var as = _q_appendData("salvaca", "", true);
                            if (as[0] != undefined) {
                                var salvacas = _q_appendData("salvacas", "", true);
                                for (var i = 0; i < salvacas.length; i++) {
                                    if (salvacas[i].sssno == $('#txtSssno').val()) {
                                        $('#txtHr_special').val(salvacas[i].inday);
                                        if (q_cur == 1){
                                        	t_tot_special = salvacas[i].total;
                                        	$('#txtTot_special').val(salvacas[i].total);
                                        	$('#txtHr_used').val('0.0');
                                        }
                                        break;
                                    }
                                }
                            }
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtSssno':
                        if (!emp($('#txtSssno').val())) {
	                        //找員工的特休假可用天數和特休假剩餘天數
	                        var t_where = "where=^^ noa ='" + $('#txtBdate').val().substr(0, 3) + "' ^^";
	                        q_gt('salvaca', t_where, 0, 0, 0, "", r_accy);
	                    }
                        var jobname = $('#txtJob').val();
                        if (jobname.indexOf('副總') != -1)
                            $('#txtSendboss').val('1');
                        else
                            $('#txtSendboss').val('0');
                        break;
					case 'txtHtype':
                        if ($('#txtHname').val().indexOf('特休') > -1)
                        q_tr('txtTot_special', t_tot_special - q_float('txtHr_used'));
                    
	                    if ($('#txtHname').val().indexOf('抵工時') > -1)
	                    	$("#btnCarryforwards").removeAttr("disabled");
	                    else
	                    	$("#btnCarryforwards").attr("disabled", "disabled");
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('salvacause_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtBdate').val(q_date());
                $('#txtEdate').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                t_tot_special = dec($('#txtTot_special').val()) + dec($('#txtHr_used').val())
                _btnModi();
                $('#txtHr_used').focus();
                
                if(r_rank<8 && !q_authRun(2))
                	$('#txtSssno').attr('readonly', true);
            }

            function btnPrint() {
                q_box('z_salvacause.aspx' + "?;;;;" + ";noa=" + $('#txtNoa').val(), '', "95%", "650px", q_getMsg("popPrint"));
            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')], ['txtSssno', q_getMsg('lblSss')], ['txtHname', q_getMsg('txtHtype')]]);

                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
               	if(dec($('#txtHr_used').val())==0)
                	change_hr_used();
                	
                /*if(q_getPara('sys.project').toUpperCase()=='DC'){ //1060110後面不適用
                	if(r_rank<8 && r_userno!='040136'){
                		if($('#txtDatea').val()>$('#txtBdate').val() || $('#txtDatea').val()>$('#txtEdate').val()){
                			alert('請假日期不得在申請日期之前!!');
                    		return;
                		}
                	}
                }*/
               
				//判斷抵工時
                if($('#txtHname').val().indexOf('抵工時')>-1){
                	//判斷抵扣工時與請假時數是否相等
                	var c_used=0,c_memo=$('#txtCarryforwards').val().split(',');//抵扣時數
                	for (var i = 0; i < c_memo.length; i=i+2) {
	            		c_used=q_add(c_used,dec(c_memo[i+1]));
					}
                	if(c_used!=dec($('#txtHr_used').val())){
                		alert("抵扣工時與請假時數不符!!");
                		return;
                	}
                }else{
                	$('#txtCarryforwards').val('');
                }
                	
                var t_noa = trim($('#txtNoa').val());

                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (q_cur == 1 || q_cur == 2) {
                	if($('#txtHname').val().indexOf('抵工時') > -1)
						$("#btnCarryforwards").removeAttr("disabled");
					else
						$("#btnCarryforwards").attr("disabled", "disabled");
				} else {
					$("#btnCarryforwards").attr("disabled", "disabled");
				}
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
            
            function change_hr_used() {
                if (!emp($('#txtBtime').val()) && !emp($('#txtEtime').val()) && (q_cur==1 || q_cur==2)) {
					if ($('#txtBtime').val() > $('#txtEtime').val()) {
						var time = $('#txtBtime').val();
						$('#txtBtime').val($('#txtEtime').val());
						$('#txtEtime').val(time);
					}
                    var use_hr = 0;
                    if(q_getPara('sys.project').toUpperCase()=='DC'){
                    	//105/10/11 只能請XX:00 或XX:30
                    	if($('#txtBtime').val().slice(-2)!='00' && $('#txtBtime').val().slice(-2)!='30'){
                    		if($('#txtBtime').val().slice(-2)>='30'){
                    			$('#txtBtime').val($('#txtBtime').val().substr(0,3)+'30');
                    		}else{
                    			$('#txtBtime').val($('#txtBtime').val().substr(0,3)+'00');
                    		}
                    	}
                    	if($('#txtEtime').val().slice(-2)!='00' && $('#txtEtime').val().slice(-2)!='30'){
                    		if($('#txtEtime').val().slice(-2)>='30'){
                    			$('#txtEtime').val($('#txtEtime').val().substr(0,3)+'30');
                    		}else{
                    			$('#txtEtime').val($('#txtEtime').val().substr(0,3)+'00');
                    		}
                    	}
                    		
                    	if ($('#txtEtime').val() >= '13:30' && $('#txtBtime').val() <= '12:00') {
                        	use_hr = round(((dec($('#txtEtime').val().substr(0, 2)) - dec($('#txtBtime').val().substr(0, 2))) * 60 + dec($('#txtEtime').val().substr(3, 2)) - dec($('#txtBtime').val().substr(3, 2))) / 60, 1);
                            use_hr = use_hr - 1.5;
                            //大昌休息時間從12點到13點半
						} else if ($('#txtBtime').val() >= '12:00' && $('#txtBtime').val() < '13:30' && $('#txtEtime').val() >= '13:30') {
                        	use_hr = round(((dec($('#txtEtime').val().substr(0, 2)) - 13) * 60 + dec($('#txtEtime').val().substr(3, 2)) - 30) / 60, 1);
						} else if ($('#txtEtime').val() >= '12:00' && $('#txtEtime').val() < '13:30' && $('#txtBtime').val() >= '12:00') {
                        	use_hr = round(((12 - dec($('#txtBtime').val().substr(0, 2))) * 60 + 0 - dec($('#txtBtime').val().substr(3, 2))) / 60, 1);
						} else {
                        	use_hr = round(((dec($('#txtEtime').val().substr(0, 2)) - dec($('#txtBtime').val().substr(0, 2))) * 60 + dec($('#txtEtime').val().substr(3, 2)) - dec($('#txtBtime').val().substr(3, 2))) / 60, 1);
						}
					} else {
                    	if ($('#txtEtime').val() >= '13:00' && $('#txtBtime').val() <= '12:00') {
                        	use_hr = round(((dec($('#txtEtime').val().substr(0, 2)) - dec($('#txtBtime').val().substr(0, 2))) * 60 + dec($('#txtEtime').val().substr(3, 2)) - dec($('#txtBtime').val().substr(3, 2))) / 60, 1);
                            use_hr = use_hr - 1.0;
						} else if ($('#txtBtime').val() >= '12:00' && $('#txtBtime').val() < '13:00' && $('#txtEtime').val() >= '13:00') {
                        	use_hr = round(((dec($('#txtEtime').val().substr(0, 2)) - 13) * 60 + dec($('#txtEtime').val().substr(3, 2)) - 30) / 60, 1);
						} else if ($('#txtEtime').val() >= '12:00' && $('#txtEtime').val() < '13:00' && $('#txtBtime').val() >= '12:00') {
                        	use_hr = round(((12 - dec($('#txtBtime').val().substr(0, 2))) * 60 + 0 - dec($('#txtBtime').val().substr(3, 2))) / 60, 1);
						} else {
                        	use_hr = round(((dec($('#txtEtime').val().substr(0, 2)) - dec($('#txtBtime').val().substr(0, 2))) * 60 + dec($('#txtEtime').val().substr(3, 2)) - dec($('#txtBtime').val().substr(3, 2))) / 60, 1);
						}
					}

                    if ($('#txtBdate').val() != $('#txtEdate').val()) {
                    	var t_date = $('#txtBdate').val();
                    	t_date=q_cdn(t_date,1);
                        var count = 0;
                        while (t_date <= $('#txtEdate').val()) {
                        	var iswork=true,ishwork=false;//判斷是否要上班,假日主檔上班日
                        	for(var i=0;i<holidayas.length;i++){
                        		if(holidayas[i].noa==t_date){
                        			if(holidayas[i].iswork.toUpperCase()=='TRUE'){//上班日
                        				ishwork=true;
                        				iswork=true;
                        			}else{
                        				iswork=false;
                        			}
                        		}
                        	}
                        	
                        	if(!ishwork){//假日主檔非上班日 判斷是否為六日
                        		if(r_len==3){
                        			if(new Date(dec(t_date.substr(0, r_len)) + 1911, dec(t_date.substr(r_len+1, 2)) - 1, dec(t_date.substr(r_lenm+1, 2))).getDay() == 0|| new Date(dec(t_date.substr(0, r_len)) + 1911, dec(t_date.substr(r_len+1, 2)) - 1, dec(t_date.substr(r_lenm+1, 2))).getDay() == 6){
                        				iswork=false;
                        			}
                        		}
                        		if(r_len==4){
                        			if(new Date(dec(t_date.substr(0, r_len)), dec(t_date.substr(r_len+1, 2)) - 1, dec(t_date.substr(r_lenm+1, 2))).getDay() == 0|| new Date(dec(t_date.substr(0, r_len)), dec(t_date.substr(r_len+1, 2)) - 1, dec(t_date.substr(r_lenm+1, 2))).getDay() == 6){
                        				iswork=false;
                        			}
                        		}
                        	}
                        	
                        	
                        	if (iswork) {
								count++;
							}
                            	
                            //日期加一天
                            t_date=q_cdn(t_date,1);
						}

                        use_hr = use_hr +(8* count);
					}

                    $('#txtHr_used').val(use_hr);
				}
            }
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
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
                /*width: 9%;*/
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
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
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
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview" style="float: left;  width:30%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:22%"><a id='vewNamea'> </a></td>
						<td align="center" style="width:43%"><a id='vewBdate'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='namea'>~namea</td>
						<td align="center" id='bdate edate'>~bdate ~ ~edate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr>
						<td style="width: 110px;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td style="width: 170px;"><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td style="width: 140px;"><!--<input id="btnAuto"  type="button" />--></td>
						<td style="width: 140px;"> </td>
						<td style="width: 140px;"> </td>
						<td style="width: 140px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td ><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtBdate"  type="text" class="txt" style="width: 120px;"/>
							<a style="float:left;">~</a>
							<input id="txtEdate"  type="text" class="txt" style="width: 120px;"/>
						</td>
					</tr>
					<tr>
						<td ><span> </span><a id='lblSss' class="lbl btn"> </a></td>
						<td>
							<input id="txtSssno"  type="text"  class="txt c2"/>
							<input id="txtNamea"  type="text"  class="txt c3"/>
						</td>
						<td ><span> </span><a id='lblPart' class="lbl"> </a></td>
						<td>
							<input id="txtPartno"  type="text"  class="txt c2"/>
							<input id="txtPart"  type="text"  class="txt c3"/>
						</td>
						<!--106/09/05 暫時先將身分證拿掉避免個資外洩-->
						<!--<td><span> </span><a id='lblId' class="lbl"> </a></td>
						<td><input id="txtId"  type="text" class="txt c1" /></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblJob' class="lbl"> </a></td>
						<td>
						<input id="txtJob"  type="text" class="txt c1" />
						<input id="txtJobno"  type="text" style="display:none;" />
						<input id="txtSendboss"  type="text" style="display:none;" />
						</td>
					</tr>
					<tr>
						<td ><span> </span><a id='lblHtype' class="lbl btn" > </a></td>
						<td>
							<input id="txtHtype"  type="text"  class="txt c2"/>
							<input id="txtHname"  type="text"  class="txt c3"/>
						</td>
						<td ><span> </span><a id='lblHr_special' class="lbl"> </a></td>
						<td><input id="txtHr_special"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTot_special' class="lbl"> </a></td>
						<td><input id="txtTot_special"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td ><span> </span><a id='lblBtime' class="lbl"> </a></td>
						<td>
							<input id="txtBtime"  type="text" class="txt" style="width: 65px;"/>
							<a style="float:left;">~</a>
							<input id="txtEtime"  type="text" class="txt" style="width: 65px;"/>
						</td>
						<td><span> </span><a id='lblHr_used' class="lbl"> </a></td>
						<td><input id="txtHr_used"  type="text" class="txt num c1"/></td>
						<td style="text-align: center;"><input id="btnCarryforwards"  type="button" style="display: none;float: none;"/></td>
						<td><input id="txtCarryforwards"  type="hidden" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAgent' class="lbl btn"> </a></td>
						<td colspan="5"><input id="txtAgent"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
