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
            var q_name = "vcc";
            var q_readonly = ['txtNoa','txtComp','txtNick','txtCardeal','txtSales','txtCno','txtAcomp','txtMoney','txtTax','txtTotal','txtWorker','txtWorker2','txtTranstart','txtStore','txtStatus','txtOrdeno'];
            var q_readonlys = ['txtTotal', 'txtNo2','txtNoq'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 10;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';

            aPop = new Array(
                ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,tel,fax,zip_comp,addr_comp,trantype,custno2,cust2', 'txtCustno,txtComp,txtNick,txtTel', 'cust_b.aspx'],
                ['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
                ['txtRackno_', 'btnRackno_', 'rack', 'noa,rack,storeno,store', 'txtRackno_', 'rack_b.aspx'],
                ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
                ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
                ['txtSalesno', 'lblSales', 'sss', 'noa,namea,partno,part', 'txtSalesno,txtSales', 'sss_b.aspx'],
                ['txtSalesno2', 'lblSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx'],
                ['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit,price', 'txtProductno_,txtProduct_,txtSpec_,txtPrice_', 'ucaucc_b.aspx'],
                ['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']
            );

            $(document).ready(function() {
                q_desc = 1;
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function sum() {
                if(!(q_cur==1 || q_cur==2)){
                    return;
                }
                var t1 = 0, t_unit, t_mount=0, t_mount1=1, t_weight = 0,t_money=0, t_tax = 0, t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_mount = q_float('txtMount_' + j);
                    t_weight=+q_float('txtMount_' + j);
                    $('#txtTotal_' + j).val(round(q_mul(q_float('txtPrice_' + j), dec(t_mount)), 0));
					
					$('#txtMount_'+j).val(round(parseFloat(t_mount),2));
                    t_money = q_add(t_money, dec(q_float('txtTotal_' + j)));
                }
                calTax();
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                bbmNum = [   ['txtMoney', 15, 0, 1], ['txtTax', 15, 0, 1],['txtTotal', 15, 0, 1]];
                bbsNum = [['txtPrice', 12, q_getPara('vcc.pricePrecision'), 1], ['txtMount', 9, q_getPara('vcc.mountPrecision'), 1], ['txtTotal', 15, 0, 1]];
                
                q_cmbParse("cmbTypea", q_getPara('vcc.typea'));
                q_cmbParse("combPay", ('').concat(new Array('　　　　','現金','刷卡','支付宝')));
                q_cmbParse("cmbStatus", ('').concat(new Array('已出貨','未出貨','　　　　')));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                
                var t_where = "where=^^ 1=0  ^^ stop=100";
                q_gt('custaddr', t_where, 0, 0, 0, "");
                $('#lblType1').text('出貨情況');
                $('#lblProductno').text('產品編號');
                $('#lblProduct').text('產品名稱');
                $('#lblStoreno').text('倉庫編號');
                $('#lblStore1').text('倉庫名稱');
                $('#lblStoremount').text('倉庫數量');
                //限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
				$('#txtMemo').change(function(){
                    if ($('#txtMemo').val().substr(0,1)=='*')
                        $('#txtMon').removeAttr('readonly');
                    else
                        $('#txtMon').attr('readonly', 'readonly');
                });
                $('#txtMon').click(function(){
                    if ($('#txtMon').attr("readonly")=="readonly" && (q_cur==1 || q_cur==2))
                        q_msg($('#txtMon'), "月份要另外設定，請在"+q_getMsg('lblMemo')+"的第一個字打'*'字");
                });
                $('#txtTax').change(function() {
                    sum();
                });
                $('#txtPrice').change(function() {
                    sum();
                });
				
                $('#lblInvono').click(function() {
                    t_where = '';
                    t_invo = $('#txtInvono').val();
                    if (t_invo.length > 0) {
                        t_where = "charindex(noa,'" + t_invo + "')>0";
                        q_box("vcca_rb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcca', "95%", "95%", $('#lblInvono').val());
                    }
                });
                $('#lblInvo').click(function() {
                    t_where = '';
                    t_invo = $('#txtInvo').val();
                    if (t_invo.length > 0) {
                        t_where = "noa='" + t_invo + "'";
                        q_box("invo.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", $('#lblInvo').val());
                    }
                });
                
                $('#txtCustno').change(function() {
                    if (!emp($('#txtCustno').val())) {
                        var t_where = "where=^^ noa='" + $('#txtCustno').val() + "'  ^^ stop=100";
                        q_gt('custaddr', t_where, 0, 0, 0, "");
                    }
                });
                
                $('#btnClose_div_stk').click(function() {
                    $('#div_stk').hide();
                });
				
            }
            
            function refreshBbm() {
               if(!emp($('#txtInvo').val())){
                    $('#chkIsgenvcca').attr('disabled', 'disabled');
                    $('#txtInvono').attr('disabled', 'disabled');
                }
            }

            function bbsGetOrdeList(){
                var t_custno = $.trim($('#txtCustno').val());
                if(t_custno.length > 0){
                    var PnoArray = [];
                    for(var j=0;j<q_bbsCount;j++){
                        var t_productno = $.trim($('#txtProductno_'+j).val());
                        var t_no2 = $.trim($('#txtNo2_'+j).val());
                        //if((t_productno.length > 0) && (t_ordeno.length==0) && (t_no2.length==0)){
                        if((t_productno.length > 0) && (t_no2.length==0)){
                            PnoArray.push("'"+t_productno+"'");
                        }
                    }
                    if(PnoArray.length > 0){
                        var t_where = 'where=^^ 1=1 ';
                        t_where += "and ((select isnull(enda,0) from view_orde where noa=a.noa)!=1) ";//BBM未結案
                        t_where += "and (isnull(enda,0)!=1) ";//BBS未結案
                        t_where += "and (custno=N'"+t_custno+"')";
                        t_where += "and (productno in (" +PnoArray.toString()+ "))";
                        q_gt('view_ordes', t_where, 0, 0, 0, "GetOrdeList");
                    }
                }
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'orde':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                break;
                            //寫入訂單號碼
                            var t_oredeno = '';
                            for (var i = 0; i < b_ret.length; i++) {
                                if (t_oredeno.indexOf(b_ret[i].noa) == -1)
                                    t_oredeno = t_oredeno + (t_oredeno.length > 0 ? (',' + b_ret[i].noa) : b_ret[i].noa);
                            }
                            //取得訂單備註 + 指定地址
                            if (t_oredeno.length > 0) {
                                var t_where = "where=^^ charindex(noa,'" + t_oredeno + "')>0 ^^";
                                q_gt('orde', t_where, 0, 0, 0, "", r_accy);
                            };
                        }
                        break;
                    case 'ordes':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                break;
                            
                            //1221 檢查 訂單是否重覆匯入
                            for (var i = 0; i < b_ret.length; i++) {
                                for (var j = 0; j < q_bbsCount; j++) {
                                    if(b_ret[i].no2==$('#txtNo2_'+j).val()){
                                        b_ret.splice(i, 1);
                                        i--;
                                        break;
                                    }
                                }
                            }
                            
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtNo2,txtPrice,txtMount,txtMemo', b_ret.length, b_ret, 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2,price,notv,memo', 'txtProductno,txtProduct,txtSpec,txtpriec');
                            sum();
                        }
                        break;
                    case 'cng':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0) {
                                b_pop = '';
                                return;
                            }
                            if(b_ret[0].noa!=undefined){
                                $('#txtStoreno').val(b_ret[0].storeno);
                                $('#txtStore').val(b_ret[0].store);
                                
                                var t_where = "where=^^typea='4' and noa='"+b_ret[0].noa+"' and mount-isnull(b.rmount,0)>0 ^^";
                                q_gt('cngs_re', t_where, 0, 0, 0, "", r_accy);  
                            }
                        }
                        break;
                    case 'cngs':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0) {
                                break;
                            }
                            
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtMount,txtNo2'
                                , b_ret.length, b_ret, 'productno,product,unit,umount,noa,noq', 'txtProductno,txtProduct');
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                if(s2[0]!=undefined){
                    if(s2[0]=='view_ucaucc'){
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (b_ret.length>0)
                                b_ret.splice(0, 1);
                            if (b_ret.length>0)
                                ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec', b_ret.length, b_ret, 'noa,product,spec,unit', 'txtProductno,txtProduct,txtSpec');
                        }
                    }
                }
                b_pop = '';
                sum();
            }

            var t_msg = '';
            var focus_addr = '';
            var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
            var carnoList = [];
            var thisCarSpecno = '';
            function q_gtPost(t_name) {
                var as;
                switch (t_name) {
                    case 'cngs_re':
                        var as = _q_appendData("view_cngs", "", true);
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtMount,txtNo2'
                                , as.length, as, 'productno,product,unit,umount,noa,noq', 'txtProductno,txtProduct');
                        break;
                    case 'GetOrdeList':
                        var as = _q_appendData("view_ordes", "", true);
                        for(var k=0;k<q_bbsCount;k++){
                            var thisPno = $.trim($('#txtProductno_'+k).val());
                            if(thisPno.length > 0){
                                $('#combOrdelist_'+k+' option').remove();
                                $('#combOrdelist_'+k).append($("<option></option>").attr("value",'').text('')); 
                                for(var j=0;j<as.length;j++){
                                    if(as[j].productno==thisPno){
                                        var FullOrdeno = $.trim(as[j].noa) + '-' + $.trim(as[j].no2);
                                        $('#combOrdelist_'+k).append($("<option></option>").attr("value",FullOrdeno).text(FullOrdeno)); 
                                    }
                                }
                            }
                        }
                        break;
                    case 'msg_stk_all':
                        var as = _q_appendData("stkucc", "", true);
                        var rowslength=document.getElementById("table_stk").rows.length-3;
                            for (var j = 1; j < rowslength; j++) {
                                document.getElementById("table_stk").deleteRow(3);
                            }
                        var stk_row=0;
                        
                        var stkmount = 0;
                        for (var i = 0; i < as.length; i++) {
                            //倉庫庫存
                            if(dec(as[i].mount)!=0){
                                var tr = document.createElement("tr");
                                tr.id = "bbs_"+j;
                                tr.innerHTML = "<td id='assm_tdStoreno_"+stk_row+"'><input id='assm_txtStoreno_"+stk_row+"' type='text' class='txt c1' value='"+as[i].storeno+"' disabled='disabled'/></td>";
                                tr.innerHTML+="<td id='assm_tdStore_"+stk_row+"'><input id='assm_txtStore_"+stk_row+"' type='text' class='txt c1' value='"+as[i].store+"' disabled='disabled' /></td>";
                                tr.innerHTML+="<td id='assm_tdMount_"+stk_row+"'><input id='assm_txtMount_"+stk_row+"' type='text' class='txt c1 num' value='"+as[i].mount+"' disabled='disabled'/></td>";
                                var tmp = document.getElementById("stk_close");
                                tmp.parentNode.insertBefore(tr,tmp);
                                stk_row++;
                            }
                            //庫存總計
                            stkmount = stkmount + dec(as[i].mount);
                        }
                        var tr = document.createElement("tr");
                        tr.id = "bbs_"+j;
                        tr.innerHTML="<td colspan='2' id='stk_tdStore_"+stk_row+"' style='text-align: right;'><span id='stk_txtStore_"+stk_row+"' class='txt c1' >倉庫總計：</span></td>";
                        tr.innerHTML+="<td id='stk_tdMount_"+stk_row+"'><span id='stk_txtMount_"+stk_row+"' type='text' class='txt c1 num' > "+stkmount+"</span></td>";
                        var tmp = document.getElementById("stk_close");
                        tmp.parentNode.insertBefore(tr,tmp);
                        stk_row++;
                        ///不主動顯示庫存
                        /*$('#div_stk').css('top',mouse_point.pageY-parseInt($('#div_stk').css('height')));
                        $('#div_stk').css('left',mouse_point.pageX-parseInt($('#div_stk').css('width')));
                        $('#div_stk').toggle();*/
                        break;
                    case 'cno_acomp':
                        var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {
                            z_cno = as[0].noa;
                            z_acomp = as[0].acomp;
                            z_nick = as[0].nick;
                        }
                        break;
                    case 'msg_ucc':
                        var as = _q_appendData("ucc", "", true);
                        t_msg = '';
                        if (as[0] != undefined) {
                            t_msg = "銷售單價：" + dec(as[0].saleprice) + "<BR>";
                        }
                        //客戶售價
                        var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and datea<'" + q_date() + "' ^^ stop=1";
                        q_gt('quat', t_where, 0, 0, 0, "msg_quat", r_accy);
                        break;
                    case 'msg_quat':
                        var as = _q_appendData("quats", "", true);
                        var quat_price = 0;
                        if (as[0] != undefined) {
                            for (var i = 0; i < as.length; i++) {
                                if (as[0].productno == $('#txtProductno_' + b_seq).val())
                                    quat_price = dec(as[i].price);
                            }
                        }
                        t_msg = t_msg + "最近報價單價：" + quat_price + "<BR>";
                        //最新出貨單價
                        var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and noa in (select noa from vccs" + r_accy + " where productno='" + $('#txtProductno_' + b_seq).val() + "' and price>0 ) ^^ stop=1";
                        q_gt('vcc', t_where, 0, 0, 0, "msg_vcc", r_accy);
                        break;
                    case 'msg_vcc':
                        var as = _q_appendData("vccs", "", true);
                        var vcc_price = 0;
                        if (as[0] != undefined) {
                            for (var i = 0; i < as.length; i++) {
                                if (as[0].productno == $('#txtProductno_' + b_seq).val())
                                    vcc_price = dec(as[i].price);
                            }
                        }
                        t_msg = t_msg + "最近出貨單價：" + vcc_price;
                        q_msg($('#txtPrice_' + b_seq), t_msg);
                        break;
                    case 'msg_stk':
                        var as = _q_appendData("stkucc", "", true);
                        var stkmount = 0;
                        t_msg = '';
                        for (var i = 0; i < as.length; i++) {
                            stkmount = stkmount + dec(as[i].mount);
                        }
                        t_msg = "庫存量：" + stkmount;
                        //平均成本
                        var t_where = "where=^^ productno ='" + $('#txtProductno_' + b_seq).val() + "' order by datea desc ^^ stop=1";
                        q_gt('wcost', t_where, 0, 0, 0, "msg_wcost", r_accy);
                        break;
                    case 'msg_wcost':
                        var as = _q_appendData("wcost", "", true);
                        var wcost_price;
                        if (as[0] != undefined) {
                            if (dec(as[0].mount) == 0) {
                                wcost_price = 0;
                            } else {
                                wcost_price = round(q_div(q_add(q_add(q_add(dec(as[0].costa), dec(as[0].costb)), dec(as[0].costc)), dec(as[0].costd)), dec(as[0].mount)), 0);
                            }
                        }
                        if (wcost_price != undefined) {
                            t_msg = t_msg + "<BR>平均成本：" + wcost_price;
                            q_msg($('#txtMount_' + b_seq), t_msg);
                        } else {
                            //原料成本
                            var t_where = "where=^^ productno ='" + $('#txtProductno_' + b_seq).val() + "' order by mon desc ^^ stop=1";
                            q_gt('costs', t_where, 0, 0, 0, "msg_costs", r_accy);
                        }
                        break;
                    case 'msg_costs':
                        var as = _q_appendData("costs", "", true);
                        var costs_price;
                        if (as[0] != undefined) {
                            costs_price = as[0].price;
                        }
                        if (costs_price != undefined) {
                            t_msg = t_msg + "<BR>平均成本：" + costs_price;
                        }
                        q_msg($('#txtMount_' + b_seq), t_msg);
                        break;
                    case 'orde':
                        var as = _q_appendData("orde", "", true);
                        var ass = _q_appendData("ordes", "", true);
                        var t_memo = $('#txtMemo').val();
                        var t_post = '';
                        var t_addr = '';
                        var t_post2 = '';
                        var t_addr2 = '';
                        for ( i = 0; i < as.length; i++) {
                            t_memo = t_memo + (t_memo.length > 0 ? '\n' : '') + as[i].memo;
                            t_post = t_post+(t_post.length>0?';':'')+as[i].post;
                            t_addr = t_addr+(t_addr.length>0?';':'')+as[i].addr;
                            t_post2 = t_post2+(t_post2.length>0?';':'')+as[i].post2;
                            t_addr2 = t_addr2+(t_addr2.length>0?';':'')+as[i].addr2;
                        }
                        $('#txtMemo').val(t_memo);
                        if (as[0] != undefined){
                            $('#txtCustno').val(as[0].custno);
                            //取得收款客戶
                            var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
                            q_gt('cust', t_where, 0, 0, 0, "cust_cust2");
                            $('#txtComp').val(as[0].comp);
                            $('#txtNick').val(as[0].nick);
                            $('#txtTel').val(as[0].tel);
                            $('#txtSalesno').val(as[0].salesno);
                            $('#txtSales').val(as[0].sales);
                            var t_where = "where=^^ noa='"+as[0].salesno+"' ^^";
                            q_gt('sss', t_where, 0, 0, 0, "sss");
                            $('#txtPaytype').val(as[0].paytype);
                            //$('#txtStoreno').val(as[0].postname);
                            //$('#txtStore').val(as[0].conform);
                            $('#cmbTaxtype').val(as[0].taxtype);
                            $('#txtInvono').val(as[0].ordbno);
                            $('#txtInvo').val(as[0].ordbno);
                        }
                        //寫入bbs
                        //1221 檢查 訂單是否重覆匯入 ordeno
                        for (var i = 0; i < ass.length; i++) {
                            for (var j = 0; j < q_bbsCount; j++) {
                                if(ass[i].no2==$('#txtNo2_'+j).val()){
                                    ass.splice(i, 1);
                                    i--;
                                    break;
                                }
                            }
                        }
                        for (var  j = 0; j < ass.length; j++) {
                            if(ass[j].enda=="true" || ass[j].cancel=="true"){
                                ass.splice(j, 1);
                                j--;
                            }
                        }
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtNo2,txtPrice,txtMount,txtMemo', ass.length, ass, 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2,price,notv,memo', 'txtProductno,txtProduct,txtSpec');
                        sum();
                        refreshBbm();
                        break;
                    case 'cust':
                        var as = _q_appendData("cust", "", true);
                        if (as[0] != undefined && focus_addr != '') {
                            $('#' + focus_addr).val(as[0].addr_fact);
                            focus_addr = '';
                        }
                        break;
                    case 'btnDele':
                        var as = _q_appendData("umms", "", true);
                        if (as[0] != undefined) {
                            var z_msg = "", t_paysale = 0;
                            for (var i = 0; i < as.length; i++) {
                                t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
                                if (t_paysale != 0)
                                    z_msg += String.fromCharCode(13) + '收款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
                            }
                            if (z_msg.length > 0) {
                                alert('已沖帳:' + z_msg);
                                Unlock(1);
                                return;
                            }
                        }
                        _btnDele();
                        Unlock(1);
                        break;
                    case 'btnModi':
                        var as = _q_appendData("umms", "", true);
                        var z_msg = "", t_paysale = 0;
                        if (as[0] != undefined) {
                            for (var i = 0; i < as.length; i++) {
                                t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
                                if (t_paysale != 0)
                                    z_msg += String.fromCharCode(13) + '收款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
                            }
                            if (z_msg.length > 0) {
                                alert('已沖帳:' + z_msg);
                                //Unlock(1);
                                //return;
                            }
                        }
                        _btnModi();
                        Unlock(1);
                        
                        //104/10/07 出貨 已收款 ，只開放表頭修改
                        if(z_msg.length>0){
                            $('.dbbs input').attr('disabled','disabled');
                            $('#cmbTaxtype').attr('disabled','disabled');
                        }
                        
                        $('#txtDatea').focus();
                        if (!emp($('#txtCustno').val())) {
                            var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
                            q_gt('custaddr', t_where, 0, 0, 0, "");
                        }
                        bbsGetOrdeList();
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    case 'startdate':
                        var as = _q_appendData('cust', '', true);
                        var t_startdate='';
                        if (as[0] != undefined) {
                            t_startdate=as[0].startdate;
                        }
                        if(t_startdate.length==0 || ('00'+t_startdate).slice(-2)=='00' || $('#txtDatea').val().substr(7, 2)<('00'+t_startdate).slice(-2)){
                            $('#txtMon').val($('#txtDatea').val().substr(0, 6));
                        }else{
                            var t_date=$('#txtDatea').val();
                            var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,1);
                            nextdate.setMonth(nextdate.getMonth() +1)
                            t_date=''+(nextdate.getFullYear()-1911)+'/'+(nextdate.getMonth()<9?'0':'')+(nextdate.getMonth()+1);
							$('#txtMon').val(t_datea);
                        }
                        check_startdate=true;
                        btnOk();
                        break;
                    case 'checkisgenvcca':
                        var as = _q_appendData('vcca', '', true);
                        if (as[0] != undefined) {
                            check_vcca=false;
                            alert("該訂單已開立過發票，請勿自動產生發票!!");
                        }else{
                            check_vcca=true;
                            btnOk();
                        }
                        break;
                }
            }
            var check_startdate=false;
            var check_vcca=false;
            var check_stkucc=false;
            var check_stk=0;
            var check_stk_notv=0;
            var checkstktmp=[];
            function btnOk() {
                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')], ['txtCustno', q_getMsg('lblCust')], ['txtCno', q_getMsg('lblAcomp')],['txtStoreno', q_getMsg('lblStore')], ['txtSalesno', q_getMsg('lblSales')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                Lock(1);
                //105/01/28 增加庫存安全量判斷 只做總倉的控管 所以出貨只判斷總倉
                var t_pwhere='1=0';
                if($('#cmbTypea').val() != '2' && $('#txtStoreno').val() == '001' &&!check_stkucc){
                    checkstktmp=[];
                    for (var i = 0; i < q_bbsCount; i++) {
                        if(!emp($('#txtProductno_'+i).val())){
                            t_pwhere=t_pwhere+(t_pwhere.length>0?" or ":"")+"productno= '"+$('#txtProductno_'+i).val()+"'";
                            if(checkstktmp.length==0){
                                checkstktmp.push({
                                    noa:$('#txtProductno_'+i).val(),
                                    product:$('#txtProduct_'+i).val(),
                                    mount:dec($('#txtMount_'+i).val()),
                                    stkmount:0,
                                    safe:0
                                })
                            }else{
                                var intmp=false;
                                for(var j=0;j<checkstktmp.length;j++){
                                    if($('#txtProductno_'+i).val()==checkstktmp[j].noa){
                                        intmp=true;
                                        checkstktmp[j].mount=q_add(dec(checkstktmp[j].mount),dec($('#txtMount_'+i).val()));
                                    }
                                    if(intmp)
                                        break;
                                }
                                if(!intmp){
                                    checkstktmp.push({
                                        noa:$('#txtProductno_'+i).val(),
                                        product:$('#txtProduct_'+i).val(),
                                        mount:dec($('#txtMount_'+i).val()),
                                        stkmount:0,
                                        safe:0
                                    });
                                }
                            }
                        }
                    }
                }
                
                //105/08/24 調整庫存抓取方式 加速處理速度
                if(checkstktmp.length>0 &&!check_stkucc){
                    var t_where = "where=^^ ['" + q_date() + "','" + $('#txtStoreno').val() + "','')  where "+t_pwhere+" ^^";
                    q_gt('calstk', t_where, 0, 0, 0, "btnOkcheckstk", r_accy,1);
                    var sas = _q_appendData("stkucc", "", true);
                    
                    var t_where = "where=^^ isnull(enda,0)=0 and isnull(cancel,0)=0 and notv>0 and ("+t_pwhere+") ^^";
                    q_gt('view_ordes', t_where, 0, 0, 0, "btnOkchecknotv", r_accy,1);
                    var oas = _q_appendData("view_ordes", "", true);
                    
                    for(var i=0; i<checkstktmp.length; i++){
                        for(var j=0; j<sas.length; j++){
                            if(checkstktmp[i].noa==sas[j].productno){
                                checkstktmp[i].stkmount=dec(sas[j].mount);
                                checkstktmp[i].safemount=dec(sas[j].safemount);
                                break;
                            }
                        }
                        var tnotv=0;
                        for(var j=0; j<oas.length; j++){
                            if(checkstktmp[i].noa==oas[j].productno){
                                tnotv=q_add(tnotv,dec(oas[j].notv))
                            }
                        }
                        checkstktmp[i].unvcc=tnotv;
                    }
                    
                    //庫存資料接收完畢 判斷庫存是否低於安全存量
                    if(q_cur==2){//修改 將原出貨單的數量補回庫存量
                        for (var i = 0; i < abbsNow.length; i++) {
                            for(var j=0; j<checkstktmp.length; j++){
                                if(abbsNow[i].productno==checkstktmp[j].noa){
                                    checkstktmp[j].stkmount=q_add(dec(checkstktmp[j].stkmount),dec(abbsNow[i].mount));
                                    break;
                                }
                            }
                        }
                    }
                        
                    var x_err='';
                    for(var j=0; j<checkstktmp.length; j++){
                        if(q_sub(q_sub(checkstktmp[j].stkmount,checkstktmp[j].unvcc),checkstktmp[j].mount)<0){
                            x_err+=checkstktmp[j].product+"庫存低於0"+(checkstktmp[j].unvcc>0?'(訂單未交量:'+checkstktmp[j].unvcc+')':'')+"\n";
                        }else if(q_sub(q_sub(checkstktmp[j].stkmount,checkstktmp[j].unvcc),checkstktmp[j].mount)<checkstktmp[j].safemount){
                            x_err+=checkstktmp[j].product+"庫存低於安全存量"+(checkstktmp[j].unvcc>0?'(訂單未交量:'+checkstktmp[j].unvcc+')':'')+"\n";
                        }
                    }
                    if(x_err.length>0){
                        Unlock(1);
                        if (confirm(x_err+"是否要繼續出貨?")){
                            check_stkucc=true;
                        }else{
                            check_stkucc=false;
                            return;
                        }
                    }else{
                        check_stkucc=true;
                    }
                }else{ // 表身無資料
                    check_stkucc=true;
                }
                
                Unlock(1);
                //判斷是否手動開過開票或再訂單已開發票
                if(!check_vcca && $('#chkIsgenvcca').prop('checked') &&!emp($('#txtOrdeno').val())){
                    var t_where = "where=^^ trdno='"+$('#txtOrdeno').val()+"' and isnull([type],'') !='' ^^";
                    q_gt('vcca', t_where, 0, 0, 0, "checkisgenvcca", r_accy);
                    return;
                }
                
                //判斷起算日,寫入帳款月份
                //104/09/30 如果備註沒有*字就重算帳款月份
                //if(!check_startdate && emp($('#txtMon').val())){
                if(!check_startdate && $('#txtMemo').val().substr(0,1)!='*'){   
                    var t_where = "where=^^ noa='"+$('#txtCustno').val()+"' ^^";
                    q_gt('cust', t_where, 0, 0, 0, "startdate", r_accy);
                    return;
                }
                /*if (emp($('#txtMon').val()))
                    $('#txtMon').val($('#txtDatea').val().substr(0, 6));*/
                
                check_startdate=false;
                check_vcca=false;
                check_stkucc=false;
                
                //106/09/15檢查出貨數量是否大於訂單數量 避免重複匯入同樣2次出貨單
                t_err='';
                
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                for (var i = 0; i < q_bbsCount; i++) {
                    if(!emp($('#txtProductno_'+i).val())){
                        $('#txtStoreno_'+i).val($('#txtStoreno').val());
                        $('#txtStore_'+i).val($('#txtStore').val());
                    }
                }
                    
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                    
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if ((s1.length == 0 || s1 == "AUTO") && $('#cmbTypea').val() == '1')
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + $('#txtDatea').val(), '/', ''));
                else if ((s1.length == 0 || s1 == "AUTO") && $('#cmbTypea').val() == '2')
                    q_gtnoa(q_name, replaceAll('B' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
				
            }
			
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('vcc_rb_s.aspx', q_name + '_s', "500px", "660px", q_getMsg("popSeek"));
            }
		
            function combPay_chg() {
                var cmb = document.getElementById("combPay");
                if (!q_cur)
                    cmb.value = '';
                else
                    $('#txtPaytype').val(cmb.value);
                cmb.value = '';
            }
            function combStatus_chg() {
                var cmb = document.getElementById("cmbStatus");
                if (!q_cur)
                    cmb.value = '';
                else
                    $('#txtStatus').val(cmb.value);
                cmb.value = '';
            }
            var mouse_point;
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                        $('#combOrdelist_'+i).change(function(){
                            var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
                            var thisVal = $.trim($(this).val());
                            var ValArray = thisVal.split('-');
                            if(ValArray[0] && ValArray[1]){
                                $('#txtNo2_' + n).val(ValArray[1]);
                            }
                            $(this).val('');
                        });
                        $('#txtPrice_' + i).focusout(function() {
                            sum();
                        });
                        
                        $('#txtMount_' + i).focusout(function() {
                            if (q_cur == 1 || q_cur == 2)
                                sum();
                                $('#btnClose_div_stk').click();
                        });
                        
                        $('#txtMount_' + i).focusin(function(e) {
                            if (q_cur == 1 || q_cur == 2) {
                                t_IdSeq = -1;
                                q_bodyId($(this).attr('id'));
                                b_seq = t_IdSeq;
                                if (!emp($('#txtProductno_' + b_seq).val())) {
                                    //庫存
                                    //var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "')  ^^";
                                    //q_gt('calstk', t_where, 0, 0, 0, "msg_stk", r_accy);
                                    //顯示DIV 104/03/21
                                    mouse_point=e;
                                    mouse_point.pageY=$('#txtMount_'+b_seq).offset().top;
                                    mouse_point.pageX=$('#txtMount_'+b_seq).offset().left;
                                    document.getElementById("stk_productno").innerHTML = $('#txtProductno_' + b_seq).val();
                                    document.getElementById("stk_product").innerHTML = $('#txtProduct_' + b_seq).val();
                                    //庫存
                                    var t_where = "where=^^ ['" + q_date() + "','"+$('#txtStoreno').val()+"','" + $('#txtProductno_' + b_seq).val() + "') ^^";
                                    q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
                                }
                            }
                        });
                        $('#txtPrice_' + i).focusin(function() {
                            if (q_cur == 1 || q_cur == 2) {
                                t_IdSeq = -1;
                                q_bodyId($(this).attr('id'));
                                b_seq = t_IdSeq;
                                if (!emp($('#txtProductno_' + b_seq).val())) {
                                    var t_where = "where=^^ noa='" + $('#txtProductno_' + b_seq).val() + "' ^^ stop=1";
                                    q_gt('ucc', t_where, 0, 0, 0, "msg_ucc", r_accy);
                                }
                            }
                        });

                        $('#btnRecord_' + i).click(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            //t_where = "cust='" + $('#txtCustno').val() + "' and noq='" + $('#txtProductno_' + b_seq).val() + "'";
                            t_where = "custno='" + $('#txtCustno').val() + "' and comp='" + $('#txtComp').val() + "' and productno='" + $('#txtProductno_' + b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "'";
                            q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
                        });
                        
                        $('#btnStk_' + i).mousedown(function(e) {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if (!emp($('#txtProductno_' + b_seq).val()) && $("#div_stk").is(":hidden")) {
                                mouse_point=e;
                                document.getElementById("stk_productno").innerHTML = $('#txtProductno_' + b_seq).val();
                                document.getElementById("stk_product").innerHTML = $('#txtProduct_' + b_seq).val();
                                //庫存
                                var t_where = "where=^^ ['" + q_date() + "','"+$('#txtStoreno').val()+"','" + $('#txtProductno_' + b_seq).val() + "') ^^";
                                q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
                            }
                        });
                    }
                }
                _bbsAssign();
                HiddenTreat();
                refreshBbm();
            }

            function btnIns() {
                _btnIns();
                $('#txtInvono').val('');
                $('#chkIsgenvcca').prop('checked',true);
                //$('#txtMon').val('');
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtCno').val(z_cno);
                $('#txtAcomp').val(z_acomp);
                $('#txtDatea').val(q_date());
                $('#cmbTypea').val('1');
                $('#txtDatea').focus();
				$('#txtWorker').val(r_name);
                $('#txtPaytype').val('現金'); //預設現金 (因為現場銷售)
				$('#txtStoreno').val('000');  //預設台北小倉
                $('#txtStore').val('台北小倉');  //預設台北小倉
                $('#txtStatus').val('已出貨');  //預設已出貨 (因為現場銷售)
				$('#txtSalesno').val(r_userno);
				$('#txtSales').val(r_name);
                $('#cmbTaxtype').val(q_getPara('sys.d4taxtype'));
				/////產生民國年 "t_date.getFullYear();-1911"
				var t_date = new Date();
				var t_year = t_date.getFullYear();
				var t_month = t_date.getMonth()+1;
				$('#txtMon').val(t_year+'/'+(t_month<10?'0':'')+t_month);
				//$('#txtDatea').val(t_year+'/'+(t_month<10?'0':'')+t_month+'/'+(t_day<10?'0':'')+t_day);
				
				
                if (!emp($('#txtCustno').val())) {
                    var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
                    q_gt('custaddr', t_where, 0, 0, 0, "");
                }
                $('#txtTotal').val(1);
                
                //105/06/07 原抓製單人部門 改成抓業務部門
                var t_where = "where=^^ noa='"+r_partno+"' ^^";
                q_gt('part', t_where, 0, 0, 0, "getpart");
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                Lock(1, {
                    opacity : 0
                });
                //1110 禁止修改貨單
                $('#cmbTypea').attr('disabled', 'disabled');
                
                var t_where = " where=^^ vccno='" + $('#txtNoa').val() + "'^^";
                q_gt('umms', t_where, 0, 0, 0, 'btnModi', r_accy);
            }

            function btnPrint() {
                var t_invono=trim($('#txtInvono').val()).split(',');
                var t_tinvono=t_invono[0]+','+t_invono[(t_invono.length-1)];
                var t_xinvono=trim($('#txtInvono').val()).substr(0,15);
                
                q_box('z_vccp_rb.aspx' + "?;;;noa='" + trim($('#txtNoa').val()) + "' and invo='" + t_tinvono  + "' and ordeno='" + t_xinvono+"';" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['typea'] = abbm2['typea'];
                as['mon'] = abbm2['mon'];
                as['noa'] = abbm2['noa'];
                as['datea'] = abbm2['datea'];
                as['custno'] = abbm2['custno'];
                if (abbm2['storeno'])
                    as['storeno'] = abbm2['storeno'];

                t_err = '';
                if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
                    t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';
                if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
                    t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

                if (t_err) {
                    alert(t_err);
                    return false;
                }
                return true;
            }

            function q_stPost() {
                if (q_cur == 1 || q_cur == 2) {
                    var s2 = xmlString.split(';');
                    abbm[q_recno]['accno'] = s2[0];
                    
                    if(s2[1]!=undefined)
                        abbm[q_recno]['invono'] = s2[1];
                    
                    if(q_getPara('sys.project').toUpperCase()=='RB')
                        q_func('qtxt.query.vcc2cng_rb', 'vcc.txt,vcc2cng_rb,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(r_name));
						q_func('qtxt.query.vcc_rb2toorde', 'test.txt,vcc_rb2toorde,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()));//回寫訂單測試的txt
                        //q_func('qtxt.query.vcc_rb2toorde', 'vcc.txt,vcc_rb2toorde,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(r_name));
                }
            }

            function refresh(recno) {
                _refresh(recno);
                HiddenTreat();
                refreshBbm();
                if(!emp($('#txtNoa').val())){
                    var t_where = " where=^^ vccno='" + $('#txtNoa').val() + "'^^";
                    q_gt('umms', t_where, 0, 0, 0, '', r_accy);
                }
            }

            function HiddenTreat(returnType){
                returnType = $.trim(returnType).toLowerCase();
                var hasStyle = q_getPara('sys.isstyle');
                var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
                var hasSpec = q_getPara('sys.isspec');
                var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
                var hasRackComp = q_getPara('sys.rack');
                var isRack = (hasRackComp.toString()=='1'?$('.isRack').show():$('.isRack').hide());
                if(returnType=='style'){
                    return (hasStyle.toString()=='1');
                }else if(returnType=='spec'){
                    return (hasSpec.toString()=='1');
                }else if(returnType=='rack'){
                    return (hasRackComp.toString()=='1');
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#combPay').attr('disabled', 'disabled');
                } else {
                    $('#combPay').removeAttr('disabled');
                }
                HiddenTreat();
                //限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
                if ($('#txtMemo').val().substr(0,1)=='*')
                    $('#txtMon').removeAttr('readonly');
                else
                    $('#txtMon').attr('readonly', 'readonly');
                refreshBbm();
            }

            function btnMinus(id) {
                _btnMinus(id);
                var n=id.split('_')[id.split('_').length-1];
                $('#combOrdelist_'+n+' option').remove();
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                dataErr = !_q_appendData(t_Table);
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
                Lock(1, {
                    opacity : 0
                });
                var t_where = " where=^^ vccno='" + $('#txtNoa').val() + "'^^";
                q_gt('umms', t_where, 0, 0, 0, 'btnDele', r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtCustno':
                        if (!emp($('#txtCustno').val())) {
                            var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
                            q_gt('custaddr', t_where, 0, 0, 0, "");
                        }
                        bbsGetOrdeList();
                        break;
                    case 'txtProductno_':
                        bbsGetOrdeList();
                        break;
                }
            }

            function FormatNumber(n) {
                var xx = "";
                if (n < 0) {
                    n = Math.abs(n);
                    xx = "-";
                }
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
            
            function calTax() {
                var t_money = 0, t_tax = 0, t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_money += q_float('txtTotal_' + j);
                }
                t_total = t_money;
                
                var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
                switch ($('#cmbTaxtype').val()) {
                    case '0': // 無
                        t_tax = 0;
                        t_total = q_add(t_money, t_tax);
                        break;
                    case '1': // 應稅
                        t_tax = round(q_mul(t_money, t_taxrate), 0);
                        t_total = q_add(t_money, t_tax);
                        break;
                    case '2': //零稅率
                        t_tax = 0;
                        t_total = q_add(t_money, t_tax);
                        break;
                    case '3': // 內含
                        t_tax = round(q_mul(q_div(t_money, q_add(1, t_taxrate)), t_taxrate), 0);
                        t_total = t_money;
                        t_money = q_sub(t_total, t_tax);
                        break;
                    case '4': // 免稅
                        t_tax = 0;
                        t_total = q_add(t_money, t_tax);
                        break;
                    case '5': // 自定
                        $('#txtTax').attr('readonly', false);
                        $('#txtTax').css('background-color', 'white').css('color', 'black');
                        t_tax = round(q_float('txtTax'), 0);
                        t_total = q_add(t_money, t_tax);
                        break;
                    case '6': // 作廢-清空資料
                        t_money = 0, t_tax = 0, t_total = 0;
                        break;
                    default:
                }
                $('#txtMoney').val(FormatNumber(t_money));
                $('#txtTax').val(FormatNumber(t_tax));
                $('#txtTotal').val(FormatNumber(t_total));
            }
			function btnvcctype(){
				if(confirm("退貨確認警告:請問是否要退貨此商品??")){
					alert("開始退貨");
				}else{
					alert("取消退貨");
				}
			}
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 30%;
                border-width: 0px;
            }
            .tview {
                width: 100%;
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
                width: 70%;
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
            .tbbm tr td .lbl1 {
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 30%;
                float: left;
            }
            .txt.c3 {
                width: 68%;
                float: left;
            }
            .txt.c4 {
                width: 49%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
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
    <body>
        <div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
            <table id="table_stk" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
                <tr>
                    <td style="background-color: #f8d463;" align="center"><span> </span><a id="lblProductno"></a></td>
                    <td style="background-color: #f8d463;" colspan="2" id='stk_productno'> </td>
                </tr>
                <tr>
                    <td style="background-color: #f8d463;" align="center"><span> </span><a id="lblProduct"></a></td>
                    <td style="background-color: #f8d463;" colspan="2" id='stk_product'> </td>
                </tr>
                <tr id='stk_top'>
                    <td align="center" style="width: 30%;"><span> </span><a id="lblStoreno"></a></td>
                    <td align="center" style="width: 45%;"><span> </span><a id="lblStore1"></a></td>
                    <td align="center" style="width: 25%;"><span> </span><a id="lblStoremount"></a></td>
                </tr>
                <tr id='stk_close'>
                    <td align="center" colspan='3'>
                        <input id="btnClose_div_stk" type="button" value="關閉視窗">
                    </td>
                </tr>
            </table>
        </div>
        <div id="dmain" style="width: 1258px;" ><!--#include file="../inc/toolbar.inc"-->
            <div class="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td align="center" style="width:5%"><a id='vewType'> </a></td>
                        <td align="center" style="width:25%"><a id='vewDatea'> </a></td>
                        <td align="center" style="width:25%"><a id='vewNoa'> </a></td>
                        <td align="center" style="width:40%"><a id='vewComp'> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td align="center" id='typea=vcc.typea'>~typea=vcc.typea</td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='noa'>~noa</td>
                        <td align="center" id='nick'>~nick</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm' id='dbbm'><!--- style="width: 900px;"--->
                <table class="tbbm" id="tbbm" style="width: 100%;height: 362px;" border="2">
                    <tr>
                        <td width="70%">
                            <table border="0" >
                                <tr>
									<td colspan="10">
										<span> </span><font size="6"><b>現場銷售系統</b></font>
										<input style="float: right;" class="btn" id="btnvcctype" onClick="btnvcctype()" type="button" value='退貨' /><hr>
									</td>
                                <tr>
                                    <td width="100px"><span> </span><a id="lblNoa" class="lbl"> </a></td>
                                    <td width="115px"><input id="txtNoa" type="text" class="txt c1" /></td>
                                    <td colspan="6">
                                        <a id="lblDatea" class="lbl" style="float: left;"> </a><span style="float: left;"> </span>
											<input id="txtDatea" type="text" class="txt c1" style="width: 80px;float: left;"/>
											<span style="float: left;"> </span><span style="float: left;"> </span><span style="float: left;"> </span>
                                        <a id="lblMon" class="lbl" style="float: left;"> </a> <span style="float: left;"> </span>
                                        <input id="txtMon" type="text" class="txt c1" style="width: 75px;float: left;"/>
										<a id="lblType" class="lbl1"></a><select id="cmbTypea"> </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
                                    <td class="td2"><input id="txtCno" type="text" class="txt c1"/></td>
                                    <td class="td2" colspan="8"><input id="txtAcomp" type="text" class="txt c1"/></td>
                                </tr>
                                <tr>
                                    <td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
                                    <td class="td2"><input id="txtCustno" type="text" class="txt c1"/></td>
                                    <td class="td2" colspan="3">
										<input id="txtComp" type="text" class="txt c1" style="width:65%;" placeholder="客戶名稱"/>
										<input id="txtNick" type="text" class="txt c1" style="width:35%;" placeholder="客戶簡稱"/>
									</td>
                                    <td class="td3" colspan="5"><input id="txtTel" type="text" class="txt c1" size="20%" placeholder="客戶電話"/></td>
                                </tr>
                                <tr>
                                    <td class="td1"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
                                    <td class="td2"><input id="txtSalesno" type="text" class="txt c1"/></td>
                                    <td class="td3"><input id="txtSales" type="text" class="txt c1"/></td>
                                    <td colspan="3" width="50px"><span> </span><a id="lblStore" class="lbl btn"> </a></td>
                                    <td><input id="txtStoreno" type="text" class="txt c1" style="width:49%;"/><input id="txtStore" type="text" class="txt c1" style="width:49%;"/></td>
                                </tr>
                                <tr>
                                    <td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
                                    <td class="td2" colspan="7"><textarea id="txtMemo" cols="10" rows="5" style="width:99%;height:50px;"> </textarea></td>
                                </tr>
                                <tr>
                                    <td ><span> </span><a id="lblOrdeno" class="lbl"></a></td>
                                    <td colspan="2"><input id="txtOrdeno" type="text" class="txt c1" placeholder="AUTO" /></td>
                                    <td colspan="2"><span> </span><a id="lblWorker" class="lbl"></a></td>
                                    <td colspan="5">
										<input id="txtWorker" type="text" class="txt c1" style="width:49%;" /><input id="txtWorker2" type="text" class="txt c1"style="width:49%;" />
									</td>
                                </tr>
                            </table>
                        </td>
                        <td width="28%" >
                            <table border="0">
                                <tr>
                                    <td colspan="2"><a id="lblIsgenvcca" class="lbl"> </a></td>
                                    <td><input id="chkIsgenvcca" type="checkbox" checked /></td>
                                </tr>
                                <tr>
                                    <td width="30%"><a id="lblInvono" class="lbl btn vcca"> </a></td>
                                    <td>
                                        <input id="txtInvono" type="text" class="txt c1 vcca" style="width: 80%;"/>
                                        <input id="txtInvo" type="hidden" class="txt c1"/><!---有值表示訂單轉發票-->
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td><span> </span><a id="lblPay" class="lbl"> </a></td>
                                    <td>
                                        <input id="txtPaytype" type="text" class="txt c1" style="width: 48%;"/>
                                        <select id="combPay" style="width: 12%;" onchange="combPay_chg()"> </select>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td><span> </span><a id="lblTranmoney" class="lbl"> </a></td>
                                    <td><input id="txtTranmoney" type="text" class="txt num c1" style="width: 80%;"/></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblMoney" class="lbl"> </a></td>
                                    <td><input id="txtMoney" type="text" class="txt num c1" style="width: 80%;"/></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblTax" class="lbl"> </a></td>
                                    <td>
                                        <input id="txtTax" type="text" class="txt num c1 istax" style="width: 30%;"/>
                                        <select id="cmbTaxtype" style="width: 49%;" onchange="calTax();"> </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblTotal" class="lbl istax"> </a></td>
                                    <td><input id="txtTotal" type="text" class="txt num c1 istax" style="width: 80%;"/></td>
                                </tr>
                                <tr>
                                    <td><a class="lbl" id="lblType1"></a></td>
                                    <td><input id="txtStatus" type="text" class="txt c1" style="width: 49%;"/>
										<select id="cmbStatus" style="width: 12%;" onchange="combStatus_chg();"> </select></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class='dbbs' style="width: 1259px;">
            <table id="tbbs" class='tbbs'>
                <tr style='color:White; background:#003366;' >
                    <td align="center" style="width:40px;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;width:" /></td>
                    <td align="center" style="width:139px"><a id='lblProductno_s'> </a></td>
                    <td align="center" style="width:350px;"><a id='lblProduct_s'> </a></td>
                    <td align="center" style="width:95px;" class="isStyle"><a id='lblStyle_s'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblTotal_s'> </a></td>
                    <td align="center" style="display: none;"><a id='lblStore_s'> </a></td>
                    <td align="center" style="width:100px;" class="isRack"><a id='lblRackno_s'> </a></td>
                    <td align="center" ><a id='lblMemo_s'> </a></td>
                    <td align="center" style="width:40px;"><a id='lblStk_s'> </a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                    <td align="center">
                        <input class="txt c1"  id="txtProductno.*" type="text" />
                        <input id="txtNoq.*" type="text" class="txt c6"/>
                        <input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;" />
                    </td>
                    <td>
                        <input id="txtProduct.*" type="text" class="txt c1" />
                        <input id="txtSpec.*" type="text" class="txt c1 isSpec" />
                    </td>
                    <td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1"/></td>
                    <td><input id="txtMount.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtPrice.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtTotal.*" type="text" class="txt num c1"/></td>
                    <td style="display: none;">
                        <input id="txtStoreno.*" type="text" class="txt c1" style="width: 75%"/>
                        <input class="btn" id="btnStoreno.*" type="button" style=" font-weight: bold;" />
                        <input id="txtStore.*" type="text" class="txt c1"/>
                    </td>
                    <td class="isRack">
                        <input class="btn"  id="btnRackno.*" type="button" value='.' style="float:left;" />
                        <input id="txtRackno.*" type="text" class="txt c1" style="width: 70%"/>
                    </td>
                    <td>
                        <input id="txtMemo.*" type="text" class="txt c1"/>
                        <select id="combOrdelist.*" style="width: 10%;"> </select>
                        <input id="txtNo2.*" type="text" class="txt" style="width:18%;"/>
                    </td>
                    <td align="center"><input class="btn" id="btnStk.*" type="button" value='.' style="width:1%;"/></td>
                </tr>
            </table>
        </div><input id="q_sys" type="hidden" />
            
		
    </body>
</html>