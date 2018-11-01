



{include file='user/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">充值</h1>


        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="row">

                <div class="col-lg-12 col-md-12">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    <p class="card-heading">注意!</p>
                                    <p>充值完成后需刷新网页以查看余额，通常一分钟内到账。</p>
                                    {if $config["enable_admin_contact"] == 'true'}
                                        <p class="card-heading">如果没有到账请立刻联系站长：</p>
                                        {if $config["admin_contact1"]!=null}
                                            <li>{$config["admin_contact1"]}</li>
                                        {/if}
                                        {if $config["admin_contact2"]!=null}
                                            <li>{$config["admin_contact2"]}</li>
                                        {/if}
                                        {if $config["admin_contact3"]!=null}
                                            <li>{$config["admin_contact3"]}</li>
                                        {/if}
                                    {/if}
                                    <br/>
                                    <p><i class="icon icon-lg">attach_money</i>当前余额：<font color="red" size="5">{$user->money}</font> 元</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                {if $pmw!=''}
                    <div class="col-lg-12 col-md-12">
                        <div class="card margin-bottom-no">
                            <div class="card-main">
                                <div class="card-inner">
                                    <div class="row">

                                        <div class="col-lg-6 col-md-6">
                                            <p class="card-heading">TrimePay 充值</p>
                                            <div class="form-group form-group-label">
                                                <label class="floating-label" for="amount">金额</label>
                                                <input class="form-control" id="amount" type="text" >
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6">
                                            <p class="h5 margin-top-sm text-black-hint" id="qrarea"></p>
                                        </div>
                                    </div>

                                    <div class="card-action">
                                        <div class="card-action-btn pull-left">
                                            <br>
                                            <button class="btn btn-flat waves-attach" id="btnSubmit" name="type" onclick="pay('Alipay')"><img src="/images/alipay.jpg" width="50px" height="50px" /></button>
                                            <button class="btn btn-flat waves-attach" id="btnSubmit" name="type" onclick="pay('WEPAY_QR')"><img src="/images/weixin.jpg" width="50px" height="50px" /></button>
                                        </div>
                                    </div>

                                    <script src="https://cdnjs.loli.net/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
                                    <script src="https://cdn.rawgit.com/davidshimjs/qrcodejs/gh-pages/qrcode.min.js"></script>
                                    <script>
                                        var pid = 0;

                                        function pay(type){
                                            if (type==='Alipay'){
                                                if(/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
                                                    type = 'ALIPAY_WAP';
                                                } else {
                                                    type = 'ALIPAY_WEB';
                                                }
                                            }

                                            var price = parseFloat($("#amount").val());

                                            console.log("将要使用 "+ type + " 充值" + price + "元");
                                            if (isNaN(price)) {
                                                $("#result").modal();
                                                $("#msg").html("非法的金额!");
                                            }
                                            $('#readytopay').modal();
                                            $("#readytopay").on('shown.bs.modal', function () {
                                                $.ajax({
                                                    'url': "/user/payment/purchase",
                                                    'data': {
                                                        'price': price,
                                                        'type': type,
                                                    },
                                                    'dataType': 'json',
                                                    'type': "POST",
                                                    success: function (data) {
                                                        if (data.code == 0) {
                                                            console.log(data);
                                                            if(type === 'ALIPAY_WAP' || type ==='ALIPAY_WEB'){
                                                                window.location.href = data.data;
                                                            } else {
                                                                $("#qrarea").html('<div class="text-center"><p>使用微信扫描二维码支付.</p><div align="center" id="qrcode" style="padding-top:10px;"></div><p>充值完毕后会自动跳转</p></div>');
                                                                $("#readytopay").modal('hide');
                                                                var qrcode = new QRCode("qrcode", {
                                                                    render: "canvas",
                                                                    width: 100,
                                                                    height: 100,
                                                                    text: encodeURI(data.data)
                                                                });
                                                            }
                                                        } else {
                                                            $("#result").modal();
                                                            $("#msg").html(data.msg);
                                                            console.log(data);
                                                        }
                                                    }
                                                });
                                            });
                                        }

                                        </script>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}

                <div class="col-lg-12 col-md-12">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    <p class="card-heading">充值码</p>
                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="code">充值码</label>
                                        <input class="form-control" id="code" type="text">
                                    </div>
                                </div>
                                <div class="card-action">
                                    <div class="card-action-btn pull-left">
                                        <button class="btn btn-flat waves-attach" id="code-update" ><span class="icon">check</span>&nbsp;充值</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12 col-md-12">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    <div class="card-table">
                                        <div class="table-responsive">
                                            {$codes->render()}
                                            <table class="table table-hover">
                                                <tr>
                                                    <!--<th>ID</th> -->
                                                    <th>代码</th>
                                                    <th>类型</th>
                                                    <th>操作</th>
                                                    <th>使用时间</th>

                                                </tr>
                                                {foreach $codes as $code}
                                                    {if $code->type!=-2}
                                                        <tr>
                                                            <!--	<td>#{$code->id}</td>  -->
                                                            <td>{$code->code}</td>
                                                            {if $code->type==-1}
                                                                <td>金额充值</td>
                                                            {/if}
                                                            {if $code->type==10001}
                                                                <td>流量充值</td>
                                                            {/if}
                                                            {if $code->type==10002}
                                                                <td>用户续期</td>
                                                            {/if}
                                                            {if $code->type>=1&&$code->type<=10000}
                                                                <td>等级续期 - 等级{$code->type}</td>
                                                            {/if}
                                                            {if $code->type==-1}
                                                                <td>充值 {$code->number} 元</td>
                                                            {/if}
                                                            {if $code->type==10001}
                                                                <td>充值 {$code->number} GB 流量</td>
                                                            {/if}
                                                            {if $code->type==10002}
                                                                <td>延长账户有效期 {$code->number} 天</td>
                                                            {/if}
                                                            {if $code->type>=1&&$code->type<=10000}
                                                                <td>延长等级有效期 {$code->number} 天</td>
                                                            {/if}
                                                            <td>{$code->usedatetime}</td>
                                                        </tr>
                                                    {/if}
                                                {/foreach}
                                            </table>
                                            {$codes->render()}
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div aria-hidden="true" class="modal modal-va-middle fade" id="readytopay" role="dialog" tabindex="-1">
                    <div class="modal-dialog modal-xs">
                        <div class="modal-content">
                            <div class="modal-heading">
                                <a class="modal-close" data-dismiss="modal">×</a>
                                <h2 class="modal-title">正在连接支付网关</h2>
                            </div>
                            <div class="modal-inner">
                                <p id="title">感谢您对我们的支持，请耐心等待</p>
                                <img src="/images/qianbai-2.png" height="200" width="200" />
                            </div>
                        </div>
                    </div>
                </div>

                {include file='dialog.tpl'}
            </div>
        </section>
    </div>
</main>







{include file='user/footer.tpl'}