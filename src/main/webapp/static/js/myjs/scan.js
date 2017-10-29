$(top.hangge());
$(function() {
    $.fn.serializeObject = function() {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function() {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [ o[this.name] ];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    $("#machineCode").focus();
    $("#machineCode")[0].oninput =function(){
        //alert(event.keyCode);
        $.ajax({
            type: "POST",
            url:scanUrl+ 'scan/findByBarcode.do',
            data: $("#Form").serializeObject(),
            dataType:'json',
            cache: false,
            success: function(data){
                if(data.result == "success"){
                    var machine = data.data;
                    if(null!=machine && ""!=machine){
                        $("#name").val(machine.name);
                        $("#type").val(machine.typeName);
                        $("#code").val(machine.barcode);
                        $("#USERNAME").val(machine.chargeName+';'+machine.Day_Repairman+';'+machine.Night_Repairman);
                        $("#mhid").val(machine.mhid);
                    }else{
                        $("#name").val(null);
                        $("#type").val(null);
                        $("#code").val(null);
                        $("#USERNAME").val(null);
                        $("#mhid").val(null);
                    }

                }
            }
        });
    };
    //维修项目开始单选
    //$("input[name=repairType]").click(function(){
    //    if($(this).hasClass("btn-primary")){
    //        $(this).addClass("btn-default");
    //        $(this).removeClass("btn-primary");
    //    }else{
    //        $("input[name=repairType].btn-primary").removeClass("btn-primary")
    //        $("input[name=repairType].btn-primary").addClass("btn-default")
    //        $(this).addClass("btn-primary");
    //        $(this).removeClass("btn-default");
    //    }
    //    $("#operation_type").val( $("input[name=repairType].btn-primary").first().attr("dvalue"));
    //
    //});
    //维修项目多选


});
function ScanRecord(scanType){

}
function machineCodeCheck(model){
    var machineCode = $("#machineCode").val();
    var mhid = $("#mhid").val();
    if(null == machineCode || machineCode == ""){
        $("#machineCode").tips({
            side : 1,
            msg : "请扫描机器",
            bg : '#FF5080',
            time : 3
        });
        $("#machineCode").focus();
        return;
    }else if(null == mhid || mhid == ""){
        $("#machineCode").tips({
            side : 1,
            msg : "机器不存在请重新扫描",
            bg : '#FF5080',
            time : 3
        });
        $("#machineCode").val("");
        $("#machineCode").focus();
        return;
    }else{
        if(model == "wxModal"){
            $("#scan_type").val("2");
            //重置开始结束维修选项
            $("input[name=repairType]").removeClass("btn-primary");
            $("input[name=repairType]").addClass("btn-default");
            //查找该机器是否存在操作记录
            var mrepain;
            $.ajax({
                type: "POST",
                url:scanUrl+ 'machinerecord/findByMhid.do',
                data: $("#Form").serializeObject(),
                dataType:'json',
                async: false,
                cache: false,
                success: function(data){
                    if(data.result == "success"){
                        mrepain = data.data;
                        if(null!=mrepain){
                            //如果已经存在维修记录说明 这次肯定是结束维修
                            $("#operation_type").val("1");
                            $("input[name=repairType]").each(function(){
                                if($(this).attr("dvalue") == "1"){
                                    $(this).addClass("btn-primary");
                                    $(this).addClass("btn-default");
                                }
                            });
                            //$("input[name=repairType]").unbind("click");
                        }else{
                            $("#operation_type").val("0");
                            $("input[name=repairType]").each(function(){
                                if($(this).attr("dvalue") == "0"){
                                    $(this).addClass("btn-primary");
                                    $(this).addClass("btn-default");
                                }
                            });
                        }
                    }
                }
            });
            //维修项目初始化
            $.ajax({
                type: "POST",
                url:scanUrl+ 'machine/getMachineProject.do',
                data: $("#Form").serializeObject(),
                dataType:'json',
                cache: false,
                success: function(data){
                    if(data.result == "success"){
                        var repairs = data.data;
                        if(null!=repairs && ""!=repairs){
                            $("#repairProject").html("");
                            //遍历机器拥有的维修项目
                            for(var i=0;i<repairs.length;i++){
                                repair =repairs[i];
                                var shtml='<input type="button" class="btn ';
                                //判断维修项目是否需要选中
                                if(null !=mrepain){
                                    var rps = mrepain.repair_position.split(",")
                                    var bool=false;
                                    for(var j=0;j<rps.length;j++){
                                        if(rps[j] == repair.MPID){
                                            bool=true;
                                            break;
                                        }
                                    }
                                    if(bool){
                                        shtml+='btn-primary';
                                    }else{
                                        shtml+='btn-default';
                                    }
                                }else{
                                    shtml+='btn-default';
                                }
                                shtml+='" value="'+repair.repairName +'" name="repairProject" style="margin-left: 2em;margin-top: 10px;" dvalue="'+repair.MPID+'">';
                                $("#repairProject").append(shtml);
                                if((i+1)%4 == 0){
                                    $("#repairProject").append("<br/>");
                                }
                            }
                            if(null !=mrepain){
                                $("#repair_position").val(mrepain.repair_position);//设置默认值
                            }
                            //赋予按钮点击变色
                            $("input[name=repairProject]").click(function(){
                                if($(this).hasClass("btn-primary")){
                                    $(this).addClass("btn-default");
                                    $(this).removeClass("btn-primary");
                                }else{
                                    $(this).addClass("btn-primary");
                                    $(this).removeClass("btn-default");
                                }
                                //选中后给维修项目赋值

                                var repairProject =[];
                                var srepairProject =[];
                                $("input[name=repairProject].btn-primary").each(function(){
                                    repairProject.push($(this).attr("dvalue"))
                                    srepairProject.push($(this).attr("value"))
                                });
                                $("#repair_position").val(repairProject.join(","));
                                $("#repair_position_scan").val(srepairProject.join(","));
                            });

                        }
                    }
                }
            });
        }else if(model == "xsModal"){
            $("#scan_type").val("1");
        }else if(model == "byModal"){
            $("#scan_type").val("3");
            //获取保养类型
            $.ajax({
                type: "POST",
                url:scanUrl+ 'machine/getMachineProject.do',
                data: $("#Form").serializeObject(),
                dataType:'json',
                cache: false,
                success: function(data){
                    if(data.result == "success"){
                        var repairs = data.data;
                        if(null!=repairs && ""!=repairs){
                            $("#cycleType").html("");
                            //遍历机器拥有的维修项目
                            for(var i=0;i<repairs.length;i++){
                                repair =repairs[i];
                                var shtml='<input type="button" class="btn btn-default';
                                     shtml+='" value="'+repair.NAME +'" name="cycle" style="margin-left: 2em;margin-top: 10px;" dvalue="'+repair.MCID+'">';
                                $("#cycleType").append(shtml);
                                if((i+1)%4 == 0){
                                    $("#cycleType").append("<br/>");
                                }
                            }
                            //赋予按钮点击变色
                            $("input[name=cycle]").click(function(){
                                if($(this).hasClass("btn-primary")){
                                    $(this).addClass("btn-default");
                                    $(this).removeClass("btn-primary");
                                }else{
                                    $("input[name=cycle].btn-primary").removeClass("btn-primary")
                                    $("input[name=cycle].btn-primary").addClass("btn-default")
                                    $(this).addClass("btn-primary");
                                    $(this).removeClass("btn-default");
                                    $("#cycle_type").val($(this).attr("dvalue"));
                                    $("#cycle_type_scan").val($(this).attr("value"));

                                    $.ajax({
                                        type: "POST",
                                        url:scanUrl+ 'machine/getMachineCycleById.do?MCID='+$(this).attr("dvalue"),
                                        data: $("#Form").serializeObject(),
                                        dataType:'json',
                                        cache: false,
                                        success: function(data){
                                            if(data.result == "success"){
                                                var desc = data.data;
                                                if(null!=desc){
                                                    $("#cycleDesc").val(desc.BZ);
                                                }
                                            }
                                        }
                                    });
                                }
                            });

                        }
                    }
                }
            });
        }else if(model == "gggModal"){
            $("#scan_type").val("4");
            $("input[name=partsType]").removeClass("btn-primary");
            $("input[name=partsType]").addClass("btn-default");
            //查找该机器是否存在操作记录
            var machineR;
            $.ajax({
                type: "POST",
                url:scanUrl+ 'machinerecord/findByMhid.do',
                data: $("#Form").serializeObject(),
                dataType:'json',
                async: false,
                cache: false,
                success: function(data){
                    if(data.result == "success"){
                        machineR = data.data;
                        if(null!=machineR){
                            //if(null == machineR.end_date && null!=machineR.start_date){
                                $("#operation_type").val("1");
                                $("input[name=partsType]").each(function(){
                                    if($(this).attr("dvalue") == "1"){
                                        $(this).addClass("btn-primary");
                                        $(this).addClass("btn-default");
                                    }
                                });
                            //}else {
                            //    $("#operation_type").val("0");
                            //    $("input[name=partsType]").each(function(){
                            //        if($(this).attr("dvalue") == "0"){
                            //            $(this).addClass("btn-primary");
                            //            $(this).addClass("btn-default");
                            //        }
                            //    });
                            //    machineR = null;
                            //}

                        }else{
                            $("#operation_type").val("0");
                            $("input[name=partsType]").each(function(){
                                if($(this).attr("dvalue") == "0"){
                                    $(this).addClass("btn-primary");
                                    $(this).addClass("btn-default");
                                }
                            });
                        }
                    }
                }
            });
            //目标规格
            $.ajax({
                type: "POST",
                url:scanUrl+ 'machine/getMachineProject.do?rule='+new Date(),
                data: $("#Form").serializeObject(),
                dataType:'json',
                async: false,
                cache: false,
                success: function(data){
                    if(data.result == "success"){
                        var repairs = data.data;
                        if(null!=repairs && ""!=repairs){
                            $("#partsRule").html("");
                            for(var i=0;i<repairs.length;i++){
                                repair =repairs[i];
                                var shtml='<input type="button" class="btn ';
                                //判断维修项目是否需要选中
                                if(null !=machineR){
                                    if(machineR.target_rule == repair.MRID){
                                        shtml+='btn-primary';
                                    }else{
                                        shtml+='btn-default';
                                    }
                                }else{
                                    shtml+='btn-default';
                                }
                                shtml+='" value="'+repair.ruleName +'" name="machineRule" style="margin-left: 2em;margin-top: 10px;" dvalue="'+repair.MRID+'">';
                                $("#partsRule").append(shtml);
                                if((i+1)%4 == 0){
                                    $("#partsRule").append("<br/>");
                                }
                            }
                            if(null !=machineR){
                                $("#target_rule").val(machineR.target_rule);//设置默认值
                            }

                            //赋予按钮点击变色
                            $("input[name=machineRule]").click(function(){
                                if($(this).hasClass("btn-primary")){
                                    $(this).addClass("btn-default");
                                    $(this).removeClass("btn-primary");
                                }else{
                                    $("input[name=machineRule].btn-primary").removeClass("btn-primary")
                                    $("input[name=machineRule].btn-primary").addClass("btn-default")
                                    $(this).addClass("btn-primary");
                                    $(this).removeClass("btn-default");
                                    $("#target_rule").val($(this).attr("dvalue"));
                                    $("#target_rule_scan").val($(this).attr("value"));
                                }
                            });
                        }
                    }
                }
            });
            //更改部位
            $.ajax({
                type: "POST",
                url:scanUrl+ 'machine/getMachineProject.do',
                data: $("#Form").serializeObject(),
                dataType:'json',
                async: false,
                cache: false,
                success: function(data){
                    if(data.result == "success"){
                        var repairs = data.data;
                        if(null!=repairs && ""!=repairs){
                            $("#partsId").html("");
                            //遍历机器拥有的维修项目
                            for(var i=0;i<repairs.length;i++){
                                repair =repairs[i];
                                var shtml='<input type="button" class="btn ';
                                //判断维修项目是否需要选中
                                if(null !=machineR){
                                    var rps = machineR.change_position.split(",")
                                    var bool=false;
                                    for(var j=0;j<rps.length;j++){
                                        if(rps[j] == repair.MPID){
                                            bool=true;
                                            break;
                                        }
                                    }
                                    if(bool){
                                        shtml+='btn-primary';
                                    }else{
                                        shtml+='btn-default';
                                    }
                                }else{
                                    shtml+='btn-default';
                                }
                                shtml+='" value="'+repair.partsName +'" name="change_parts" style="margin-left: 2em;margin-top: 10px;" dvalue="'+repair.MPID+'">';
                                $("#partsId").append(shtml);
                                if((i+1)%4 == 0){
                                    $("#partsId").append("<br/>");
                                }
                            }
                            //设置默认值
                            if(null !=machineR){
                                $("#change_position").val(machineR.change_position);//设置默认值
                            }
                            //赋予按钮点击变色
                            $("input[name=change_parts]").click(function(){
                                if($(this).hasClass("btn-primary")){
                                    $(this).addClass("btn-default");
                                    $(this).removeClass("btn-primary");
                                }else{
                                    $(this).addClass("btn-primary");
                                    $(this).removeClass("btn-default");
                                }
                                //选中后给维修项目赋值
                                var change_parts =[];
                                var schange_parts =[];
                                $("input[name=change_parts].btn-primary").each(function(){
                                    change_parts.push($(this).attr("dvalue"));
                                    schange_parts.push($(this).attr("value"));
                                });
                                $("#change_position").val(change_parts.join(","));
                                $("#change_position_scan").val(schange_parts.join(","));
                            });

                        }
                    }
                }
            });
        }
        $('#'+model).modal("show");
    }

}
function xsScan() {
    $("#scan_type").val("1");
    var machineCode = $("#machineCode").val();
    var mhid = $("#mhid").val();
    if(null == machineCode || machineCode == ""){
        $("#machineCode").tips({
            side : 1,
            msg : "请扫描机器",
            bg : '#FF5080',
            time : 3
        });
        $("#machineCode").focus();
        return;
    }else if(null == mhid || mhid == ""){
        $("#machineCode").tips({
            side : 1,
            msg : "机器不存在请重新扫描",
            bg : '#FF5080',
            time : 3
        });
        $("#machineCode").val("");
        $("#machineCode").focus();
        return;
    }else{
        xsbtn();
    }

}
function xsbtn(){
    console.log(this);
    var scan_type = $("#scan_type").val();
    if(scan_type == "1"){
        $("#operation_type").val("");
    }else if(scan_type == "2"){
        //维修检查
        var operation_type = $("#operation_type").val();
        if(null== operation_type || operation_type=="" ){
            alert("请选择维修类型");
            return false;
        }
        var repair_position = $("#repair_position").val();
        if(null== repair_position || repair_position=="" ){
            alert("请选择维修项目");
            return false;
        }

    }else if(scan_type == "3"){
        var cycle_type = $("#cycle_type").val();
        if(null== cycle_type || cycle_type=="" ){
            alert("请选择保养类型");
            return false;
        }
    }else if(scan_type == "4"){
        //该规格检查
        var target_rule = $("#target_rule").val();
        if(null== target_rule || target_rule=="" ){
            alert("请选择目标规格");
            return false;
        }
        var change_position = $("#change_position").val();
        if(null== change_position || change_position=="" ){
            alert("请选择更改部位");
            return false;
        }
    }
    $.ajax({
        type: "POST",
        url: scanUrl+'scan/scanoperation.do',
        data: $("#Form").serializeObject(),
        dataType:'json',
        cache: false,
        success: function(data){
            if(data.result == "success"){
                alert("操作成功！")
                if(scan_type == "1"){
                    $('#xsModal').modal("hide");
                }else if(scan_type == "2"){
                    $('#wxModal').modal("hide");
                }else if(scan_type == "3"){
                    $('#byModal').modal("hide");
                }else if(scan_type == "4"){
                    $('#gggModal').modal("hide");
                }
                $("#repair_position").val("");
                $("#cycle_type").val("");
                $("#target_rule").val("");
                $("#change_position").val("");
            }else{
                alert(data.mesg);
                $("#repair_position").val("");
                $("#cycle_type").val("");
                $("#target_rule").val("");
                $("#change_position").val("");
            }
        }
    });
}