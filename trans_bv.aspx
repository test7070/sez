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

            var q_name = "transef";
            var q_readonly = ['txtNoa','txtOrdeno','txtWorker','txtWorker2','txtUnpack'];
            var bbmNum = [['txtInmount',10,0,1],['txtPton',10,0,1],['txtPrice',10,0,1],['txtPrice2',10,0,1]
                ,['txtTolls',10,0,1],['txtReserve',10,0,1],['txtOverh',10,0,1]
                ,['txtOverw',10,0,1],['txtCommission',10,0,1],['txtCommission2',10,0,1]
                ,['txtUnpack',10,0,1],['txtMount3',10,0,1],['txtMount4',10,0,1]
                ,['txtWeight2',10,0,1],['txtWeight3',10,0,1]
                ,['txtValue1',10,0,1],['txtValue2',10,0,1]];
            var bbmMask = [];
            q_sqlCount = 6;
           
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            q_xchg = 1;
            brwCount = 6;
            brwCount2 = 15;
            var string = decodeURIComponent(location.href);
            if( string.indexOf('\'all\'=\'all\'')>=0){
                //z_tran_ef10 用
                string = string.replace(/.*\'all\'=\'all\' and (\d*)=\d*.*/g,'$1');
                brwCount2 = parseInt(string);
            }
            aPop = new Array(['txtStraddrno','lblStraddr_tb','addr2','noa,addr','txtStraddrno,txtStraddr','addr2_b.aspx']
                ,['txtEndaddrno','lblEndaddr_tb','addr2','noa,addr','txtEndaddrno,txtEndaddr','addr2_b.aspx']
                ,['txtUccno','lblUcc','ucc','noa,product','txtUccno,txtProduct','ucc_b.aspx']
                ,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
                ,['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
                ,['txtCarno', 'lblCarno', 'car2', 'a.noa,driver,driverno', 'txtCarno,txtDriver,txtDriverno', 'car2_b.aspx']
                ,['txtBoatno', 'lblBoat', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']
                ,['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
                ,['txtSaddr', '', 'view_road', 'memo', '0txtSaddr', 'road_b.aspx']
                ,['txtAaddr', '', 'view_road', 'memo', '0txtAaddr', 'road_b.aspx']);
           
            function sum() {
                if(q_cur!=1 && q_cur!=2)
                    return;
                var t_price = q_float('txtPrice');
                var t_price2 = q_float('txtPrice2');
                var t_price3 = q_float('txtPrice3');
                var t_total = round(t_price,0);
                var t_total2 = round(q_add(t_price2,t_price3),0);
                
                var t_unpack = q_float('txtTolls') + q_float('txtReserve') + q_float('txtOverh')
                    +q_float('txtOverw')+q_float('txtCommission')+q_float('txtCommission2');
                $('#txtTotal').val(q_trv(t_total));
                $('#txtTotal2').val(q_trv(t_total2));
                $('#txtUnpack').val(q_trv(t_unpack));
            }
            
            function currentData() {
            }
            currentData.prototype = {
                data : [],
                /*新增時複製的欄位*/
                include : [],
                
                /*['txtDatea', 'txtTrandate','txtCarno','txtDriverno','txtDriver'
                    ,'txtCustno','txtComp','txtNick','cmbCalctype','cmbCarteamno','txtStraddrno','txtStraddr','txtEndaddrno','txtEndaddr'
                    ,'txtUccno','txtProduct','txtInmount'
                    ,'txtOutmount','txtPo','txtCustorde'],*/
                /*記錄當前的資料*/
                copy : function() {
                    this.data = new Array();
                    for (var i in fbbm) {
                        var isInclude = false;
                        for (var j in this.include) {
                            if (fbbm[i] == this.include[j]) {
                                isInclude = true;
                                break;
                            }
                        }
                        if (isInclude) {
                            this.data.push({
                                field : fbbm[i],
                                value : $('#' + fbbm[i]).val()
                            });
                        }
                    }
                },
                /*貼上資料*/
                paste : function() {
                    for (var i in this.data) {
                        $('#' + this.data[i].field).val(this.data[i].value);
                    }
                }
            };
            var curData = new currentData();
            
            function transData() {
            }
            transData.prototype = {
                calctype : new Array(), 
                isTrd : null,
                isTre : null,
                isoutside : null,            
                refresh : function(){
                    $('#lblPrice2').hide();
                    $('#txtPrice2').hide();
                    $('#lblPrice3').hide();
                    $('#txtPrice3').hide();
                    for(var i in this.calctype){
                        if(this.calctype[i].noa == $('#cmbCalctype').val()){
                            if(this.calctype[i].isoutside){
                                $('#lblPrice3').show();
                                $('#txtPrice3').show();
                            }else{
                                $('#lblPrice2').show();
                                $('#txtPrice2').show();
                            }
                        }
                    }
                    
                },
                calctypeChange : function(){
                    for(var i in this.calctype){
                        if(this.calctype[i].noa == $('#cmbCalctype').val()){
                            $('#txtDiscount').val(q_trv(this.calctype[i].discount));     
                            this.isoutside = this.calctype[i].isoutside;                            
                        }
                    }
                    this.priceChange();
                },
                priceChange : function(){
                    var t_straddrno = $.trim($('#txtStraddrno').val());
                    var t_endaddrno = $.trim($('#txtEndaddrno').val());
                    var t_date = $.trim($('#txtTrandate').val());
                    
                    t_where = " b.straddrno='"+t_straddrno+"' and b.endaddrno='"+t_endaddrno+"' and a.datea<='"+t_date+"'";
                    q_gt('addr_tb', "where=^^"+t_where+"^^", 0, 0, 0, 'getPrice_cust');
                },
                checkData : function(){
                    this.isTrd = false;
                    this.isTre = false;
                    this.isoutside = false;
                    for(var i in this.calctype){
                        if(this.calctype[i].noa == $('#cmbCalctype').val()){
                            this.isoutside = this.calctype[i].isoutside;
                        }
                    }
                    $('#txtDatea').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtTrandate').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    
                    $('#txtCustno').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtComp').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtStraddrno').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtStraddr').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtInmount').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtPton').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtPrice').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    
                    $('#txtCarno').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtDriverno').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtDriver').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtOutmount').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtPton2').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtPrice2').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtPrice3').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#txtDiscount').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
                    $('#cmbCalctype').attr('disabled','disabled');
                    $('#cmbCarteamno').attr('disabled','disabled');
                    if($('#txtOrdeno').val().length>0){
                        //轉來的一律不可改日期
                    }else{
                        var t_tranno = $.trim($('#txtNoa').val());
                        var t_trannoq = $.trim($('#txtNoq').val());
                        var t_datea = $.trim($('#txtDatea').val());
                        if(q_cur==2 && (t_tranno.length==0 || t_trannoq.length==0 || t_datea.length==0)){
                            alert('資料異常。 code:1');
                        }else{
                            //檢查是否已立帳
                            q_gt('view_trds', "where=^^ tranno='"+t_tranno+"' and trannoq='"+t_trannoq+"' ^^", 0, 0, 0, 'checkTrd_'+t_tranno+'_'+t_trannoq+'_'+t_datea,r_accy);
                        }
                    }
                }
           };
            trans = new transData();
                
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt('calctype2', '', 0, 0, 0, 'transInit1');
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
                $('#btnIns').val($('#btnIns').val() + "(F8)");
                $('#btnOk').val($('#btnOk').val() + "(F9)");
                $('#textBdate').datepicker();
                $('#textEdate').datepicker();
                
                bbmMask = [['txtDatea', r_picd],['txtTrandate', r_picd],['textBdate',r_picd],['textEdate',r_picd]];
                q_mask(bbmMask);
                $("#cmbCalctype").focus(function() {
                    var len = $("#cmbCalctype").children().length > 0 ? $("#cmbCalctype").children().length : 1;
                    $("#cmbCalctype").attr('size', len + "");
                    $(this).data('curValue',$(this).val());
                }).blur(function() {
                    $("#cmbCalctype").attr('size', '1');
                }).change(function(e){
                    trans.refresh();
                    trans.calctypeChange();
                }).click(function(e){
                    if($(this).data('curValue')!=$(this).val()){
                        trans.refresh();
                        trans.calctypeChange();
                    }
                    $(this).data('curValue',$(this).val());
                });
                $('#txtPrice').change(function(){
                    sum();
                });
                $('#txtPrice2').change(function(){
                    sum();
                });
                $('#txtPrice3').change(function(){
                    sum();
                });
                $('#txtDiscount').change(function(){
                    sum();
                });
                $('#txtInmount').change(function(){
                    sum();
                });
                $('#txtPton').change(function(){
                    sum();
                });
                $('#txtOutmount').change(function(){
                    sum();
                });
                $('#txtPton2').change(function(){
                    sum();
                });
                $('#txtBmiles').change(function(){
                    sum();
                });
                $('#txtEmiles').change(function(){
                    sum();
                });
                $('#txtTolls').change(function(){
                    sum();
                });
                $('#txtReserve').change(function(){
                    sum();
                });
                $('#txtOverh').change(function(){
                    sum();
                });
                $('#txtOverw').change(function(){
                    sum();
                });
                $('#txtCommission').change(function(){
                    sum();
                });
                $('#txtCommission2').change(function(){
                    sum();
                });
                $('#txtUnpack').change(function(){
                    sum();
                });
                $('#txtTrandate').change(function(e){
                    trans.priceChange();
                });
                $('#txtFill').change(function(e){
                    $(this).val($(this).val().toUpperCase()); 
                });
                $('#txtIo').change(function(e){
                    $(this).val($(this).val().toUpperCase()); 
                });
                $('#btnCopy').click(function(e){
                    $('#divCopy').toggle();
                });
                $('#btnTranscopy').click(function(e){
                    if($('#textBdate').val().length==0 || $('#textEdate').val().length==0){
                        alert('請輸入日期。');
                        return;
                    }
                    var t_date = q_date();
                    var t_weekday='';
                    var obj = $('#divCopy').find('input[type="checkbox"]');
                    for(var i=0;i<obj.length;i++){
                        if(obj.eq(i).prop('checked')){
                            t_weekday += ''+(i%7+1);
                        }
                    }
                    q_func('qtxt.query.transef_copy', 'transef.txt,transef_copy,' + r_userno+ ';' + r_name + ';' + $('#txtNoa').val() + ';'+ $('#textBdate').val()+ ';'+ $('#textEdate').val() + ';'+t_weekday);
                });
                $('#cmbCarteamno').blur(function(e){
                    if($('#cmbCarteamno').val()=='10'){
                        //B段
                        $('#lblMount_ef').html('起程板數');
                        $('#lblPton_ef').html('回程板數');
                    }else{
                        $('#lblMount_ef').html('件數');
                        $('#lblPton_ef').html('板數');
                    }
                }).click(function(e){
                    if($('#cmbCarteamno').val()=='10'){
                        //B段
                        $('#lblMount_ef').html('起程板數');
                        $('#lblPton_ef').html('回程板數');
                    }else{
                        $('#lblMount_ef').html('件數');
                        $('#lblPton_ef').html('板數');
                    }
                });
                q_xchgForm();
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.transef_copy':
                        location.reload();
                        break;
                }

            }

            function q_gtPost(t_name) {
                switch (t_name) { 
                    case 'getPrice_driver':
                        var t_price = 0;
                        var as = _q_appendData("addrs", "", true);
                        if(as[0]!=undefined){
                            t_price = as[0].driverprice;
                        }
                        $('#txtPrice2').val(t_price);
                        $('#txtPrice3').val(0);
                        
                        sum();
                        break; 
                    case 'getPrice_driver2':
                        var t_price = 0;
                        var as = _q_appendData("addrs", "", true);
                        if(as[0]!=undefined){
                            t_price = as[0].driverprice2;
                        }
                        $('#txtPrice2').val(0);
                        $('#txtPrice3').val(t_price);
                        
                        sum();
                        break;    
                    case 'getPrice_cust':
                        var t_price = 0;
                        var as = _q_appendData("addrs", "", true);
                        if(as[0]!=undefined){
                            t_price = as[0].custprice;
                        }
                        $('#txtPrice').val(t_price);
                        
                        var t_straddrno = $.trim($('#txtStraddrno').val());
                        var t_endaddrno = $.trim($('#txtEndaddrno').val());
                        var t_date = $.trim($('#txtTrandate').val());
                        if(trans.isoutside){
                            t_where = "b.straddrno='"+t_straddrno+"' and b.endaddrno='"+t_endaddrno+"' and a.datea<='"+t_date+"'";
                            q_gt('addr_tb', "where=^^"+t_where+"^^", 0, 0, 0, 'getPrice_driver2');
                        }else{
                            t_where = "b.straddrno='"+t_straddrno+"' and b.endaddrno='"+t_endaddrno+"' and a.datea<='"+t_date+"'";
                            q_gt('addr_tb', "where=^^"+t_where+"^^", 0, 0, 0, 'getPrice_driver');
                        }
                        break;
                    case 'transInit1':
                        var as = _q_appendData("calctypes", "", true);
                        var t_item = "";
                        if(as[0]!=undefined){
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                                trans.calctype.push({
                                    noa : as[i].noa + as[i].noq,
                                    typea : as[i].typea,
                                    discount : as[i].discount,
                                    discount2 : as[i].discount2,
                                    isoutside : as[i].isoutside.length == 0 ? false : (as[i].isoutside == "false" || as[i].isoutside == "0" || as[i].isoutside == "undefined" ? false : true)
                                });
                            }
                            q_cmbParse("cmbCalctype", t_item);
                        }
                        if(abbm[q_recno]!=undefined)
                            $("#cmbCalctype").val(abbm[q_recno].calctype);  
                       
                        q_gt('carteam', '', 0, 0, 0, 'transInit2');
                        break;
                    case 'transInit2':
                        var as = _q_appendData("carteam", "", true);
                        var t_item = "";
                        if(as[0]!=undefined){
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                            }
                            q_cmbParse("cmbCarteamno", t_item);
                        }
                        if(abbm[q_recno]!=undefined)
                            $("#cmbCarteamno").val(abbm[q_recno].carteamno);  
                            
                        q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                       
                        break;
                }
            }
            function q_popPost(id) {
                switch(id) {
                    case 'txtStraddrno':
                        trans.priceChange();
                        break;
                    case 'txtEndaddrno':
                        trans.priceChange();
                        break;
                    case 'txtUccno':
                        trans.priceChange();
                        break;
                    default:
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('trans_ef_s.aspx', q_name + '_s', "550px", "95%", q_getMsg("popSeek"));
            }

            function btnIns() {
                curData.copy();
                _btnIns();
                curData.paste();
                $('#txtNoa').val('AUTO');
                $('#txtNoq').val('001');
                if($('#cmbCalctype').val().length==0){
                    $('#cmbCalctype').val(trans.calctype[0].noa);
                }
                trans.calctypeChange();
                trans.refresh();
                $('#txtDatea').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
				//1030630取消限制修改日期
                /*if(!isEdit())
                    return;*/
                _btnModi();
                sum();
            }
            function btnPrint() {
                q_box('z_tran_ef.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function isEdit(){
                //2. 日期防呆功能：僅能輸入當月資料，其它月份資料不可輸入。
                //3. 每月25號是否將輸入功能鎖住，禁止各項資料輸入，以利結帳作業。
                var t_date =  $('#txtDatea').val();
                var t_date1 = q_date();
                var t_date2 = q_date();
                t_date = new Date(dec(t_date.substr(0, 3)) + 1911, dec(t_date.substring(4, 6)) - 1, dec(t_date.substring(7, 9)));
               
                t_date1 = new Date(dec(t_date1.substr(0, 3)) + 1911, dec(t_date1.substring(4, 6)) - 1, dec(t_date1.substring(7, 9)));
                t_date2 = new Date(dec(t_date2.substr(0, 3)) + 1911, dec(t_date2.substring(4, 6)) - 1, dec(t_date2.substring(7, 9)));
                if(t_date1.getDate()<=25){
                    //上個月26號~本月底   
                    t_date1.setDate(20);
                    t_date1.setDate(t_date1.getDate()-25);
                    t_date1.setDate(26);
                    t_date2.setDate(t_date2.getDate()+25);
                    t_date2.setDate(0);
                }else{
                    //本月26號~下個月底  
                    t_date1.setDate(26);   
                    t_date2.setDate(t_date2.getDate()+25);
                    t_date2.setDate(25);
                    t_date2.setDate(t_date2.getDate()+25);
                    t_date2.setDate(0);
                }
                if( t_date<t_date1 || t_date>t_date2){
                    alert('發送日期需在【'
                    +(t_date1.getFullYear()-1911)+'/'
                    +(t_date1.getMonth()+1<10?'0'+(t_date1.getMonth()+1):(t_date1.getMonth()+1))+'/'
                    +(t_date1.getDate()<10?'0'+t_date1.getDate():t_date1.getDate())
                    +'】~【'
                    +(t_date2.getFullYear()-1911)+'/'
                    +(t_date2.getMonth()+1<10?'0'+(t_date2.getMonth()+1):(t_date2.getMonth()+1))+'/'
                    +(t_date2.getDate()<10?'0'+t_date2.getDate():t_date2.getDate())
                    +'】');
                    return false;
                }
                return true;
            }
            function btnOk() {
                Lock(1,{opacity:0});
                //日期檢查
                if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
                    alert('發送日期錯誤。');
                    Unlock(1);
                    return;
                }
                if($('#txtTrandate').val().length == 0 || !q_cd($('#txtTrandate').val())){
                    alert('配送日期錯誤。');
                    Unlock(1);
                    return;
                }
                /*if($('#txtDatea').val().substring(0,3)!=r_accy){
                    alert('年度異常錯誤，請切換到【'+$('#txtDatea').val().substring(0,3)+'】年度再作業。');
                    Unlock(1);
                    return;
                }*/
                /*if(!isEdit()){
                    Unlock(1);
                    return;
                }*/
                var t_days = 0;
                var t_date1 = $('#txtDatea').val();
                var t_date2 = $('#txtTrandate').val();
                t_date1 = new Date(dec(t_date1.substr(0, 3)) + 1911, dec(t_date1.substring(4, 6)) - 1, dec(t_date1.substring(7, 9)));
                t_date2 = new Date(dec(t_date2.substr(0, 3)) + 1911, dec(t_date2.substring(4, 6)) - 1, dec(t_date2.substring(7, 9)));
                t_days = Math.abs(t_date2 - t_date1) / (1000 * 60 * 60 * 24) + 1;
                if(t_days>60){
                    alert('發送日期、配送日期相隔天數不可多於60天。');
                    Unlock(1);
                    return;
                }
                sum();
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
                }else{
                    alert("error: btnok!");
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (q_cur ==1)
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);        
            }

            function wrServer(key_value) {
                var i;
                $('#txtNoa').val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                trans.refresh();
                
                if($('#cmbCarteamno').val()=='10'){
                    //B段
                    $('#lblMount_ef').html('起程板數');
                    $('#lblPton_ef').html('回程板數');
                }else{
                    $('#lblMount_ef').html('件數');
                    $('#lblPton_ef').html('板數');
                }
           
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
                if (q_chkClose())
                        return;
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            function checkCaseno(string){
                var key ={0:0,1:1,2:2,3:3,4:4,5:5,6:6,7:7,8:8,9:9,A:10,B:12,C:13,D:14,E:15,F:16,G:17,H:18,I:19,J:20,K:21,L:23,M:24,N:25,O:26,P:27,Q:28,R:29,S:30,T:31,U:32,V:34,W:35,X:36,Y:37,Z:38};
                if((/^[A-Z]{4}[0-9]{7}$/).test(string)){
                    var value = 0;
                    for(var i =0;i<string.length-1;i++){
                        value+= key[string.substring(i,i+1)]*Math.pow(2,i);
                    }
                    return Math.floor(q_add(q_div(value,11),0.09)*10%10)==parseInt(string.substring(10,11));
                }else{
                    return false;
                }
            }
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 100%; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #cad3ff;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
        <input type="button" id="btnCopy" value="複製" style="width:100px;">
        <div id="divCopy" style="position:absolute; display:none;background-color: pink; width:400px;">
            <table style="width:100%;">
                <tr style="height:1px;">
                    <td style="width:10%;"> </td>
                    <td style="width:10%;"> </td>
                    <td style="width:10%;"> </td>
                    <td style="width:10%;"> </td>
                    <td style="width:10%;"> </td>
                    <td style="width:10%;"> </td>
                    <td style="width:10%;"> </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: right;">日期</td>
                    <td colspan="5">
                        <input type="text" id="textBdate" style="width:100px;float:left;"/>
                        <span  style="width:30px;float:left;text-align: center;"> ~</span>
                        <input type="text" id="textEdate" style="width:100px;float:left;"/>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;">日</td>
                    <td style="text-align: center;">一</td>
                    <td style="text-align: center;">二</td>
                    <td style="text-align: center;">三</td>
                    <td style="text-align: center;">四</td>
                    <td style="text-align: center;">五</td>
                    <td style="text-align: center;">六</td>
                </tr>
                <tr>
                    <td style="text-align: center;"><input type="checkbox" id="check0"  /></td>
                    <td style="text-align: center;"><input type="checkbox" id="check1"  /></td>
                    <td style="text-align: center;"><input type="checkbox" id="check2"  /></td>
                    <td style="text-align: center;"><input type="checkbox" id="check3"  /></td>
                    <td style="text-align: center;"><input type="checkbox" id="check4"  /></td>
                    <td style="text-align: center;"><input type="checkbox" id="check5"  /></td>
                    <td style="text-align: center;"><input type="checkbox" id="check6"  /></td>
                </tr>
                <tr style="height: 35px;">
                    
                </tr>
                <tr>
                    <td colspan="4"> </td>
                    <td colspan="3"><input type="button" id="btnTranscopy" value="確定"></td>
                </tr>
            </table>
        </div>
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:80px; color:black;">發送日期</td>
                        <td align="center" style="width:80px; color:black;">配送日期</td>
                        <td align="center" style="width:120px; color:black;">客戶</td>
                        <td align="center" style="width:80px; color:black;">貨號</td>
                        <td align="center" style="width:80px; color:black;">貨件運費</td>
                        <td align="center" style="width:60px; color:black;">件數</td>
                        <td align="center" style="width:60px; color:black;">板數</td>
                        <td align="center" style="width:80px; color:black;">起點</td>
                        <td align="center" style="width:80px; color:black;">迄點</td>
                        <td align="center" style="width:80px; color:black;">車牌號碼</td>
                        <td align="center" style="width:80px; color:black;">司機</td>
                        <td align="center" style="width:80px; color:black;">運費</td>
                    </tr>
                    <tr>
                        <td ><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="datea" style="text-align: center;">~datea</td>
                        <td id="trandate" style="text-align: center;">~trandate</td>
                        <td id="nick" style="text-align: center;">~nick</td>
                        <td id="po" style="text-align: center;">~po</td>
                        <td id="price,0" style="text-align: right;">~price,0</td>
                        <td id="inmount,0" style="text-align: right;">~inmount,0</td>
                        <td id="pton,0" style="text-align: right;">~pton,0</td>
                        <td id="straddr" style="text-align: center;">~straddr</td>
                        <td id="endaddr" style="text-align: center;">~endaddr</td>
                        <td id="carno" style="text-align: center;">~carno</td>
                        <td id="driver" style="text-align: center;">~driver</td>
                        <td id="price2,0" style="text-align: right;">~price2,0</td>
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
                        <td><span> </span><a class="lbl">發送日期</a></td>
                        <td><input id="txtDatea"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">配送日期</a></td>
                        <td><input id="txtTrandate"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblCalctype" class="lbl">計算類別</a></td>
                        <td><select id="cmbCalctype" class="txt c1"> </select></td>
                        <td><span> </span><a id="lblCarteam" class="lbl">車隊</a></td>
                        <td><select id="cmbCarteamno" class="txt c1"> </select></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCust" class="lbl btn">客戶</a></td>
                        <td colspan="3">
                            <input id="txtCustno"  type="text" style="float:left;width:30%;"/>
                            <input id="txtComp"  type="text" style="float:left;width:70%;"/>
                            <input id="txtNick" type="text" style="display:none;"/>
                        </td>
                        <td><span> </span><a class="lbl">貨號</a></td>
                        <td><input id="txtPo"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">計費方式</a></td>
                        <td><input id="txtUnit"  type="text" class="txt c1"/></td>
                    </tr>   
                    <tr>
                        <td><span> </span><a class="lbl">貨件運費</a></td>
                        <td><input id="txtPrice"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a id="lblMount_ef" class="lbl">件數</a></td>
                        <td>
                            <input id="txtInmount"  type="text" class="txt c1 num"/>
                            <input id="txtMount"  type="text" style="display:none;"/>
                        </td>
                        <td><span> </span><a id="lblPton_ef" class="lbl">板數</a></td>
                        <td><input id="txtPton"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">報單編號</a></td>
                        <td><input id="txtSo"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a class="lbl">寄件人</a></td>
                        <td><input id="txtSender"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">寄件人電話</a></td>
                        <td><input id="txtStel"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">出貨地址</a></td>
                        <td colspan="3"><input id="txtSaddr"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a class="lbl">收件人</a></td>
                        <td><input id="txtAddressee"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">收件人電話</a></td>
                        <td><input id="txtAtel"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">收貨地址</a></td>
                        <td colspan="3"><input id="txtAaddr"  type="text" class="txt c1"/></td>
                    </tr>
                    
                    <tr>
                        <td><span> </span><a id="lblStraddr_tb" class="lbl btn">起點</a></td>
                        <td colspan="2">
                            <input id="txtStraddrno"  type="text" style="float:left;width:30%;"/>
                            <input id="txtStraddr"  type="text" style="float:left;width:70%;"/>
                        </td>
                        <td><span> </span><a id="lblEndaddr_tb" class="lbl btn">迄點</a></td>
                        <td colspan="2">
                            <input id="txtEndaddrno"  type="text" style="float:left;width:30%;"/>
                            <input id="txtEndaddr"  type="text" style="float:left;width:70%;"/>
                        </td>
                        <td><span> </span><a class="lbl">卸櫃地</a></td>
                        <td><input id="txtCaseend" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblBmiles" class="lbl">里程起</a></td>
                        <td><input id="txtBmiles"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a id="lblEmiles" class="lbl">里程迄</a></td>
                        <td><input id="txtEmiles"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">行駛里程數</a></td>
                        <td><input id="txtMiles"  type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr style="background:pink;">
                        <td><span> </span><a class="lbl">班次</a></td>
                        <td colspan="2"><input id="txtCasecust"  type="text" class="txt c1"/></td>
                        <td><input id="txtCasecustno"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">支票袋</a></td>
                        <td><input id="txtMount3"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">移櫃津貼</a></td>
                        <td><input id="txtMount4"  type="text" class="txt c1 num"/></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr style="background:pink;">
                        <td><span> </span><a class="lbl">表定里程</a></td>
                        <td><input id="txtTolls"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">空車頭</a></td>
                        <td><input id="txtReserve"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">原里程增/減</a></td>
                        <td><input id="txtOverh"  type="text" class="txt c1 num"/></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr style="background:pink;">
                        <td><span> </span><a class="lbl">未請里程</a></td>
                        <td><input id="txtOverw"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">調度附掛增/減</a></td>
                        <td><input id="txtCommission"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">加班里程</a></td>
                        <td><input id="txtCommission2"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">總里程</a></td>
                        <td><input id="txtUnpack"  type="text" class="txt c1 num"/></td>
                        <td class="tdZ"></td>
                    </tr>   
                    <tr style="background:pink;">
                        <td><span> </span><a class="lbl">棧板里程</a></td>
                        <td><input id="txtWeight2"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">營收</a></td>
                        <td><input id="txtWeight3"  type="text" class="txt c1 num"/></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>                   
                    <tr style="background:burlywood;">
                        <td><span> </span><a class="lbl">板架</a></td>
                        <td><input id="txtCardno"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">加油公升數</a></td>
                        <td><input id="txtValue1"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">油費</a></td>
                        <td><input id="txtValue2"  type="text" class="txt c1 num"/></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr style="background:burlywood;">
                    	<td><span> </span><a class="lbl">尺寸</a></td>
                        <td><input id="txtCstype"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">代碼</a></td>
                        <td><input id="txtStatus"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">進出空重</a></td>
                        <td><input id="txtFill"  type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">稅內含</a></td>
                        <td><input id="txtIo"  type="text" class="txt c1"/></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr style="background:#868A08;">
                        <td><span> </span><a class="lbl">到店運費</a></td>
                        <td><input id="txtValue7"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">特殊點加價</a></td>
                        <td><input id="txtValue12"  type="text" class="txt c1 num"/></td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr style="background:#868A08;">
                    	<td><span> </span><a class="lbl">EC件數</a></td>
                        <td><input id="txtValue8"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">EC運費</a></td>
                        <td><input id="txtValue9"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">膠外件數</a></td>
                        <td><input id="txtValue10"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">膠外運費</a></td>
                        <td><input id="txtValue11"  type="text" class="txt c1 num"/></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblTggno" class="lbl btn">承運廠商</a></td>
                        <td colspan="2">
                            <input id="txtTggno"  type="text" style="float:left;width:50%;"/>
                            <input id="txtTgg"  type="text" style="float:left;width:50%;"/>
                        </td>
                        <td><span> </span><a id="lblCarno" class="lbl btn">車牌</a></td>
                        <td><input id="txtCarno"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblDriver" class="lbl btn">司機</a></td>
                        <td colspan="2">
                            <input id="txtDriverno"  type="text" style="float:left;width:50%;"/>
                            <input id="txtDriver"  type="text" style="float:left;width:50%;"/>
                        </td>
                        
                    </tr>
                    <tr>
                        <td><span> </span><a class="lbl">運費</a></td>
                        <td>
                            <input id="txtPrice2"  type="text" class="txt c1 num"/>
                            <input id="txtPrice3"  type="text" class="txt c1 num"/>
                        </td>
                        <td><span> </span><a class="lbl">路線</a></td>
                        <td colspan="2">
                            <input id="txtCaseno"  type="text" style="float:left;width:50%;"/>
                            <input id="txtCaseno2"  type="text" style="float:left;width:50%;"/>
                        </td>
                    </tr>
                   
                    <tr style="display:none;">
                        <td><span> </span><a class="lbl">應收小計</a></td>
                        <td><input id="txtTotal"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a id="lblTotal2" class="lbl"> </a></td>
                        <td><input id="txtTotal2"  type="text" class="txt c1 num"/></td>
                    </tr>               
                    <tr style="display:none;">
                        <td><span> </span><a id="lblUcc" class="lbl btn"> </a></td>
                        <td colspan="3">
                            <input id="txtUccno"  type="text" style="float:left;width:30%;"/>
                            <input id="txtProduct"  type="text" style="float:left;width:70%;"/>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td><span> </span><a id="lblBoat" class="lbl btn"> </a></td>
                        <td colspan="2">
                            <input id="txtBoatno"  type="text" style="float:left;width:50%;"/>
                            <input id="txtBoat"  type="text" style="float:left;width:50%;"/>
                        </td>
                        <td><span> </span><a id="lblShip" class="lbl"> </a></td>
                        <td colspan="2"><input id="txtShip" type="text" class="txt c1"/></td>
                    </tr>
                    <tr style="display:none;">
                        <td><span> </span><a id="lblCustorde" class="lbl"> </a></td>
                        <td colspan="2"><input id="txtCustorde" type="text" class="txt c1"/></td>
                   		<td><span> </span><a id="lblGps" class="lbl"> </a></td>
                        <td><input id="txtGps"  type="text" class="txt c1 num"/></td>
                    </tr>
                    
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl">備註</a></td>
                        <td colspan="7"><input id="txtMemo"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl">電腦編號</a></td>
                        <td>
                            <input id="txtNoa"  type="text" class="txt c1"/>
                            <input id="txtNoq"  type="text" style="display:none;"/>
                        </td>
                        <td><span> </span><a id="lblOrdeno" class="lbl">訂單號碼</a></td>
                        <td colspan="2"><input id="txtOrdeno"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWorker" class="lbl">製單員</a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblWorker2" class="lbl">修改人</a></td>
                        <td><input id="txtWorker2" type="text" class="txt c1"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
