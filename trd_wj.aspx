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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            q_tables = 's';
            var q_name = "trd";
            var q_readonly = ['txtTax', 'txtNoa', 'txtMoney', 'txtTotal','txtWorker2','txtWorker', 'txtMount', 'txtStraddr', 'txtEndaddr', 'txtPlusmoney', 'txtMinusmoney', 'txtVccano', 'txtCustchgno','txtAccno','txtAccno2','txtYear2','txtYear1'];
            var q_readonlys = [ 'txtTranno','txtTrannoq','txtTrandate','txtStraddr','txtProduct','txtCarno','txtCustorde','txtCaseno','txtMount','txtPrice','txtTotal','txtTranmoney'];
            var bbmNum = [['txtPlus', 10, 0,1],['txtDiscount', 10, 0,1],['txtMoney', 10, 0,1], ['txtTax', 10, 0,1], ['txtTotal', 10, 0,1], ['txtMount', 10, 3,1], ['txtPlusmoney', 10, 0,1], ['txtMinusmoney', 10, 0,1]];
            var bbsNum = [['txtTranmoney', 10, 0,1], ['txtOverweightcost', 10, 0,1], ['txtOthercost', 10, 0,1], ['txtMount', 10, 3,1], ['txtPrice', 10, 3,1], ['txtTotal', 10, 0,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            q_xchg = 1;
            brwCount2 = 20;
            q_bbsLen = 10;
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
            , ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtStraddrno', '', 'addr', 'noa,addr', 'txtStraddrno,txtStraddr', 'addr_b2.aspx']
            , ['txtEndaddrno', '', 'addr', 'noa,addr', 'txtEndaddrno,txtEndaddr', 'addr_b2.aspx']
            ,['txtCarno_', 'btnCarno_', 'carplate', 'noa,driver', 'txtCarno_', 'carplate_b.aspx']);
			
			var t_carteam = '';
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt('carteam', '', 0, 0, 0, "");
                
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_modiDay= q_getPara('sys.modiday2');  /// 若未指定， d4=  q_getPara('sys.modiday'); 
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtBtrandate', r_picd], ['txtEtrandate', r_picd], ['txtVccadate', r_picd]];
                q_mask(bbmMask);
                //q_cmbParse("cmbCarteamno", t_carteam);
                
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker();
				$('#txtBtrandate').datepicker();
				$('#txtEtrandate').datepicker();
                $('#lblAccno').click(function() {
                	if($('#txtYear1').val().length>0)
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtYear1').val()+ '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
                $('#lblAccno2').click(function() {
                	if($('#txtYear2').val().length>0)
                    q_pop('txtAccno2', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno2').val() + "';" + $('#txtYear2').val()+ '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
                $('#txtPlus').change(function(e){
                	sum();
                });
                $('#txtDiscount').change(function(e){
                	sum();
                });
				$('#lblCustchgno').click(function(e){
					var t_where = "1!=1";
					var t_custchgno = $('#txtCustchgno').val().split(',');
					for(var i in t_custchgno){
						if(t_custchgno[i].length>0)
							t_where += " or noa='"+t_custchgno[i]+"'";
					}
					q_box("custchg.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'custchg', "95%", "95%", q_getMsg("popCustchg"));
				});
                $('#lblVccano').click(function() {
                	var t_where = "where=^^ noa='"+$('#txtCustno').val()+"' ^^";
                	q_gt('cust', t_where, 0, 0, 0, "");
                });
                $('#btnTrans').click(function(e) {
                	if (!(q_cur == 1 || q_cur == 2))
                		return;
                	Lock(1,{opacity:0});
                	if ($.trim($('#txtCustno').val()).length == 0) {
                        alert('請輸入客戶');
                        Unlock(1);
                        return false;
                    }
                    if ($.trim($('#txtDatea').val()) == 0) {
                        alert('請輸入'+q_getMsg('lblDatea'));
                        Unlock(1);
                        return false;
                    }
                    if($('#txtDatea').val().substring(0,3)!=r_accy){
                        alert('年度異常錯誤，請切換到【'+$('#txtDatea').val().substring(0,3)+'】年度再作業。');
                        Unlock(1);
                        return;
                    }
                	var t_noa = $.trim($('#txtNoa').val());
                	var t_custno = $.trim($('#txtCustno').val());
                	var t_bdate = $.trim($('#txtBdate').val());
                	var t_edate = $.trim($('#txtEdate').val());
                	var t_btrandate = $.trim($('#txtBtrandate').val());
                	var t_etrandate = $.trim($('#txtEtrandate').val());
                	var t_baddrno = $.trim($('#txtStraddrno').val());
                	var t_eaddrno = $.trim($('#txtEndaddrno').val());
                	var t_where = "(b.noa is null or b.noa='"+t_noa+"')";
                	t_where += " and a.custno='"+t_custno+"'";
                	t_where += t_bdate.length>0?" and a.datea>='"+t_bdate+"'":"";
                	t_where += t_edate.length>0?" and a.datea<='"+t_edate+"'":"";
                	t_where += t_btrandate.length>0?" and a.trandate>='"+t_btrandate+"'":"";
                	t_where += t_etrandate.length>0?" and a.trandate<='"+t_etrandate+"'":"";
                	t_where += t_baddrno.length>0?" and a.straddrno>='"+t_baddrno+"'":"";
                	t_where += t_eaddrno.length>0?" and a.straddrno<='"+t_eaddrno+"'":"";

                	var t_po = "";
                	if ($.trim($('#txtPo').val()).length > 0) {
                        var tmp = $.trim($('#txtPo').val()).split(',');
                        t_po = ' and (';
                        for (var i in tmp)
                        t_po += (i == 0 ? '' : ' or ') + "a.po='" + tmp[i] + "'";
                        t_po += ')';
                        t_where += t_po;
                    }
                	t_where = "where=^^"+t_where+"^^";
                	q_gt('trd_tran', t_where, 0, 0, 0, "", r_accy);
                	
                });
                $("#btnCustchg").click(function(e) {
                	Lock(1,{opacity:0});
                    if ($('#txtCustno').val().length == 0) {
                        alert('請輸入客戶編號!');
                        Unlock(1);
                        return;
                    }
                    t_custchgno = 'custchgno=' + $('#txtCustchgno').val();
                    t_where = "  custno='" + $('#txtCustno').val() + "' and  (trdno='" + $('#txtNoa').val() + "' or len(isnull(trdno,''))=0) ";
                    q_box("custchg_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;" + t_custchgno + ";", 'custchg', "95%", "650px", q_getMsg('popCustchg'));
                });
                $("#btnVcca").click(function(e) {
                    Lock(1,{opacity:0});
                    if ($('#txtCustno').val().length == 0) {
                        alert('請輸入客戶編號!');
                        Unlock(1);
                        return;
                    }
                    t_vccano = 'vccano=' + $('#txtVccano').val();
                    /*未請款發票才抓*/
                    t_where = "  buyerno='" + $('#txtCustno').val() + "' and (trdno='" + $('#txtNoa').val() + "' or len(isnull(trdno,''))=0) ";
                    q_box("vcca_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;" + t_vccano + ";", 'vcca1', "95%", "650px", q_getMsg('popVcca'));
                });
            }
				
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'carteam':
						var as = _q_appendData("carteam", "", true);
						t_carteam = "@";
						if(as[0]!=undefined){
    						for ( i = 0; i < as.length; i++) {
    							t_carteam = t_carteam + (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
    						}
						}
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                		break;
                	case 'btnDele':
                		var as = _q_appendData("umms", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'收款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnDele();
                    	Unlock(1);
                		break;
                	case 'btnModi':
                		var as = _q_appendData("umms", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'收款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnModi();
		                sum();
		                Unlock(1);
		                $('#txtDatea').focus();
                		break;
                	case 'cust':
                		var t_custno2 ='',t_cust2='';
                		var as = _q_appendData("cust", "", true);
                		if(as[0]!=undefined){
                			t_custno2 = as[0].custno2;
                			t_cust2 = as[0].cust2;
                		}
                		var t_where = "";
               		 	var tmp = $('#txtVccano').val().split(',');
                    	for (var i in tmp)
                   			t_where += (t_where.length > 0 ? ' or ' : '') + "noa='" + tmp[i] + "'";
                		q_box("vcca_2.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno+";ORIGIN=TRD&ORGCUSTNO="+$('#txtCustno').val()+"&CUSTNO2="+t_custno2+"&CUST2="+t_cust2, 'vcca', "95%", "95%", q_getMsg("popVcca"));
                		break;
                    case 'custchg':
                        var as = _q_appendData("custchg", "", true);
                        var t_plusmoney = 0, t_minusmoney = 0;
                        for ( i = 0; i < as.length; i++) {
                            t_plusmoney += parseFloat(as[i].plusmoney);
                            t_minusmoney += parseFloat(as[i].minusmoney);
                        }
                        $('#txtPlusmoney').val(FormatNumber(t_plusmoney));
                        $('#txtMinusmoney').val(FormatNumber(t_minusmoney));
                        sum();
                        Unlock(1);
                        break;
                    case 'vcca1':
                        var as = _q_appendData("vcca", "", true);
                        var t_money = 0, t_tax = 0, t_total = 0;
                        for ( i = 0; i < as.length; i++) {
                            t_money += parseFloat(as[i].money);
                            t_tax += parseFloat(as[i].tax);
                            t_total += parseFloat(as[i].total);
                        }
                        $('#txtTax').val(FormatNumber(t_tax));
                        sum();
                        Unlock(1);
                        break;
                    case 'trd_tran':
                        var as = _q_appendData("view_trans", "", true);
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtTrandate,txtTranno,txtTrannoq,txtCarno,txtStraddr,txtTranmoney,txtCaseno,txtMount,txtPrice,txtTotal,txtCustorde,txtProduct'
                        , as.length, as, 'trandate,noa,noq,carno,straddr,total,caseno,mount,price,total,custorde,product', '','');
                        for ( i = 0; i < q_bbsCount; i++) {
                            if (i < as.length) {
                            }else{
                            	_btnMinus("btnMinus_" + i);
                            }
                        }
                        sum();
                        Unlock(1);
                        $('#txtCustno').focus();
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	try{
                    		var t_para = JSON.parse(t_name);
                    		if(t_para.action=="browTrans"){
                    			var as = _q_appendData("view_trans", "", true);
                    			if (as[0] != undefined) {
		                			q_box("trans.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + as[0].noa + "';" + as[0].accy, 'view_trans', "95%", "95%", q_getMsg("popTrans"));	
		                		}
                    		}
                    	}catch(e){
                    		
                    	}
                    	break;
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'custchg':
                        if (b_ret != null) {
                            var t_where = '1!=1'; 
                            $('#txtCustchgno').val('');           
                            for (var i = 0; i < b_ret.length; i++) {
                                $('#txtCustchgno').val($('#txtCustchgno').val()+($('#txtCustchgno').val().length>0?',':'')+b_ret[i].noa);
                                t_where += " or noa='" + b_ret[i].noa + "'";
                            }
                            q_gt('custchg', "where=^^" + t_where + "^^", 0, 0, 0, "");
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case 'vcca1':
                        if (b_ret != null) {
                        	var t_where = '1!=1'; 
                            $('#txtVccano').val('');           
                            for (var i = 0; i < b_ret.length; i++) {
                                $('#txtVccano').val($('#txtVccano').val()+($('#txtVccano').val().length>0?',':'')+b_ret[i].noa);
                                t_where += " or noa='" + b_ret[i].noa + "'";
                            }
                            q_gt('vcca1', "where=^^" + t_where + "^^", 0, 0, 0, "");
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                var string =  xmlString.split(';');
                if(string[0]!=undefined){
                	abbm[q_recno]['accno'] = string[0];
               		//$('#txtAccno').val(string[0]);
                }
                if(string[1]!=undefined){
                	abbm[q_recno]['year1'] = string[1];
               		//$('#txtYear1').val(string[1]);
                }	
                if(string[2]!=undefined){
                	abbm[q_recno]['accno2'] = string[2];
               		//$('#txtAccno2').val(string[2]);
                }	
                if(string[3]!=undefined){
                	abbm[q_recno]['year2'] = string[3];
               		//$('#txtYear2').val(string[3]);
                }
                //存檔產生發票
                /*switch(q_getPara('sys.project').toUpperCase()){
                	case 'WH':
                		var t_noa = $.trim($('#txtNoa').val());
                		q_func('qtxt.query.trd2vcca', 'trd.txt,trd2vcca,' + encodeURI(t_noa)); 
                		break;
                	default:
                		break;
                }*/
                
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	//BBS日期不可超過2個月
            	var t_array= new Array();
        		for ( i = 0; i < q_bbsCount; i++) {
        		    if($.trim($('#txtTrandate_'+i).val()).length>0){
        		        t_mon = $.trim($('#txtTrandate_'+i).val()).substring(0,6);
                        if(t_array.indexOf(t_mon)<0)
                            t_array.push(t_mon);
        		    }
        		}
        		
            	if(t_array.length>2){
            	    alert('資料超過2個月份。');
                    Unlock(1);
                    return;
            	}
            	if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if($('#txtDatea').val().substring(0,3)!=r_accy){
					alert('年度異常錯誤，請切換到【'+$('#txtDatea').val().substring(0,3)+'】年度再作業。');
					Unlock(1);
            		return;
				}
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
					return;
				}
				if ($('#txtMon').val().length == 0) {
                    $('#txtMon').val($('#txtDatea').val().substring(0, 6));
                }
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!");
                }         
                sum();
                
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trd') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('trd_s.aspx', q_name + '_s', "600px", "530px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtTranno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtTranno_', '');
                            q_gt('view_trans', "where=^^ noa='"+$(this).val()+"' ^^ stop=1", 0, 0, 0, JSON.stringify({action:"browTrans",n:n})); 
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtCustno').focus();
            }

            function btnModi() {
            	if (emp($('#txtNoa').val()))
                    return;
                if (q_chkClose())
             		    return;
                Lock(1,{opacity:0});
                var t_where =" where=^^ vccno='"+ $('#txtNoa').val()+"'^^";
                q_gt('umms', t_where, 0, 0, 0, 'btnModi',r_accy);
            }

            function btnPrint() {                       
                q_box('z_trd_wj.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['tranno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
               	//小數 可能會有問題需注意
                var t_money = 0,t_mount = 0;
                for ( i = 0; i < q_bbsCount; i++) {
                    t_money = t_money.add(q_float('txtTranmoney_' + i));
                    
                    t_mount = t_mount.add(q_float('txtMount_' + i));
                }
                t_mount = t_mount.round(3);
				var t_plusmoney = q_float('txtPlusmoney');
				var t_minusmoney = q_float('txtMinusmoney');
				var t_tax = q_float('txtTax'); 
				var t_plus = q_float('txtPlus');
				var t_discount = q_float('txtDiscount'); 
				var t_total = t_money.add(t_plusmoney).sub(t_minusmoney).add(t_tax).add(t_plus).sub(t_discount);
               
                $('#txtMoney').val(FormatNumber(t_money));
                $('#txtTotal').val(FormatNumber(t_total));
                $('#txtMount').val(FormatNumber(t_mount));
            }
            function refresh(recno) {
                _refresh(recno);
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (q_cur == 1 || q_cur == 2) {
                    $('#btnTrans').removeAttr('disabled');
                    $('#btnCustchg').removeAttr('disabled');
                    $('#btnVcca').removeAttr('disabled');
                } else {
                    $('#btnTrans').attr('disabled', 'disabled');
                    $('#btnCustchg').attr('disabled', 'disabled');
                    $('#btnVcca').attr('disabled', 'disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
            	if (q_chkClose())
             		    return;
                Lock(1,{opacity:0});
                var t_where =" where=^^ vccno='"+ $('#txtNoa').val()+"'^^";
                q_gt('umms', t_where, 0, 0, 0, 'btnDele',r_accy);
            }
            function btnCancel() {
                _btnCancel();
            }
			function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
			Number.prototype.round = function(arg) {
			    return Math.round(this * Math.pow(10,arg))/ Math.pow(10,arg);
			}
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			}
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""))
			        r2 = Number(arg2.toString().replace(".", ""))
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			}
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length } catch (e) { }
			    try { m += s2.split(".")[1].length } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			}
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2))
			    return (arg1 * m + arg2 * m) / m
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			}
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return parseFloat(((arg1 * m - arg2 * m) / m).toFixed(n));
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 950px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
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
                width: 950px;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 10%;
            }
            .tbbm .trX{
                background-color: #FFEC8B;
            }
            .tbbm .trY{
                background-color: #DAA520;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
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
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewComp"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewPo">P/O</a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewMoney"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewPlusmoney"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewMinusmoney"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewTax"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewTotal"> </a> </td>
						<td align="center" style="width:70px; color:black;"><a id="vewMount"> </a> </td>
						<td align="center" style="width:100px; color:black;"><a id="vewVccano"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewUnpay"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="po" style="text-align: center;">~po</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
						<td id="plusmoney,0,1" style="text-align: right;">~plusmoney,0,1</td>
						<td id="minusmoney,0,1" style="text-align: right;">~minusmoney,0,1</td>
						<td id="tax,0,1" style="text-align: right;">~tax,0,1</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
						<td id="mount" style="text-align: right;">~mount</td>
						<td id="vccano,10" style="text-align: left;" >~vccano,10</td>
						<td id="unpay,0,1" style="text-align: right;">~unpay,0,1</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno" type="text"  style='width:30%; float:left;'/>
							<input id="txtComp" type="text"  style='width:70%; float:left;'/>
							<input id="txtNick" type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr class="trX">
						<td><span> </span><a id="lblDate2" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtBdate" type="text" style="float:left; width:45%;"/>
							<span style="float:left;display: block;width:3%;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
							<input id="txtEdate" type="text" style="float:left; width:45%;"/>
						</td>
						<td><span> </span><a id="lblStraddr" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtStraddrno" type="text"  class="txt" style="float:left;width:25%;"/>
							<input id="txtStraddr" type="text"  class="txt" style="float:left;width:20%;"/>
							<span style="float:left; display:block; width:3%;">~</span>
							<input id="txtEndaddrno" type="text"  class="txt" style="float:left;width:25%;"/>
							<input id="txtEndaddr" type="text"  class="txt" style="float:left;width:20%;"/>
						</td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="trX">
						<td><span> </span><a id="lblTrandate" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtBtrandate" type="text" style="float:left; width:45%;"/>
							<span style="float:left;display: block;width:3%;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
							<input id="txtEtrandate" type="text" style="float:left; width:45%;"/>
						</td>
						<td><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtPo" type="text"  class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="trX">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><input type="button" id="btnTrans" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="trY">
						<td><span> </span><a id="lblCustchgno" class="lbl btn"> </a></td>
						<td colspan="5"><input id="txtCustchgno" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input type="button" id="btnCustchg" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="trY">
						<td><span> </span><a id="lblVccano" class="lbl btn"> </a></td>
						<td colspan="5"><input id="txtVccano" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input type="button" id="btnVcca" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCno" type="text"  class="txt" style="float: left; width:25%;"/>
							<input id="txtAcomp" type="text"  class="txt"  style="float: left; width:75%;"/>
						</td>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblPlus" class="lbl"> </a></td>
						<td><input id="txtPlus" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td><input id="txtDiscount" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td><input id="txtTax" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPlusmoney" class="lbl"> </a></td>
						<td><input id="txtPlusmoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblMinusmoney" class="lbl"> </a></td>
						<td><input id="txtMinusmoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text"  class="txt c1"/></td>
						<td><input id="txtYear1" type="text"  class="txt c1"/> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAccno2" class="lbl btn"> </a></td>
						<td><input id="txtAccno2" type="text"  class="txt c1"/> </td>
						<td><input id="txtYear2" type="text"  class="txt c1"/> </td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;"><a id='lblTrandate_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblStraddr_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblCarno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblCustorde_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblCaseno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblTranno_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTranmoney_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
					<input type="text" id="txtTrandate.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtStraddr.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtProduct.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtMount.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtPrice.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtTotal.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtCarno.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCustorde.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCaseno.*" style="width:95%;" />
					</td>
					<td>
						<input type="text" id="txtTranno.*" style="float:left; width: 90%;"/>
						<input type="text" id="txtTrannoq.*" style="float:left;visibility: hidden; width:1%"/>
					</td>
					<td >
					<input type="text" id="txtTranmoney.*" style="width:95%;text-align: right;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
