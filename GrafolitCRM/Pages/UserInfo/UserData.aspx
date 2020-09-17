<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" Title="Urejanje profila" AutoEventWireup="true" CodeBehind="UserData.aspx.cs" Inherits="AnalizaProdaje.Pages.UserInfo.UserData" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder2_ASPxRoundPanel1_clearImage").on("click", function () {
                clientClearImageCallback.PerformCallback();
            });
            
        });

        function OnClosePopupEventHandler_Prijava(param, url) {
            switch (param) {
                case 'Potrdi':
                    Prijava_Popup.Hide();
                    window.location.assign(url);//"../Default.aspx"
                    break;
                case 'Prekliči':
                    Prijava_Popup.Hide();
                    break;
            }
        }

        function onUploadControlFileUploadComplete(s, e) {
            if (e.isValid) {
                var uploadedImage = document.getElementById("ctl00_ContentPlaceHolder2_ASPxRoundPanel1_uploadedImage");
                uploadedImage.src = "/ProfileImages/" + e.callbackData;

                var externalDropZone = document.getElementById("externalDropZone");

                uploadedImage.style.left = (externalDropZone.clientWidth - uploadedImage.width) / 2 + "px";
                uploadedImage.style.top = (externalDropZone.clientHeight - uploadedImage.height) / 2 + "px";
                $("#ctl00_ContentPlaceHolder2_ASPxRoundPanel1_clearImage").show();
            }
            //setElementVisible("uploadedImage", e.isValid);
        }
        /*function onImageLoad() {
            var externalDropZone = document.getElementById("externalDropZone");
            var uploadedImage = document.getElementById("uploadedImage");
            uploadedImage.style.left = (externalDropZone.clientWidth - uploadedImage.width) / 2 + "px";
            uploadedImage.style.top = (externalDropZone.clientHeight - uploadedImage.height) / 2 + "px";
            setElementVisible("dragZone", false);
        }*/
        function setElementVisible(elementId, visible) {
            //document.getElementById(elementId).className = visible ? "" : "hidden";
        }


        function CauseValidation(s, e) {
            var procees = CheckValidData();

            if (procees)
                e.processOnServer = true;
            else
                e.processOnServer = false;
        }

        function CheckValidData() {
            var procees = true;
            if (clientUsername.GetText() == "") {
                $(clientUsername.GetInputElement()).parent().parent().addClass("focus-text-box-input-error");
                procees = false;
            }


            if (clientPassword.GetText() == "") {
                $(clientPassword.GetInputElement()).parent().parent().addClass("focus-text-box-input-error");
                procees = false;
            }

            return procees;
        }

        function ClearImageComplete(s, e) {
            $("#ctl00_ContentPlaceHolder2_ASPxRoundPanel1_clearImage").hide();
            $("#ctl00_ContentPlaceHolder2_ASPxRoundPanel1_uploadedImage").attr('src', e.result);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" ShowCollapseButton="false" runat="server" Theme="MetropolisBlue"
        HeaderStyle-HorizontalAlign="Center" Font-Bold="true" Width="100%" HeaderText="UPORABNIŠKE NASTAVITVE">
        <ContentPaddings PaddingBottom="7px" PaddingLeft="3px" PaddingRight="3px" PaddingTop="7px" />
        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="userDataWrap">
                    <div class="basicDataBlock">
                        <h2 class="titleUserDate small-margin-l">Moji osnovni podakti</h2>
                        <div class="inputUserData">
                            <div class="basicUserData">
                                <div class="section group">
                                    <div class="col span_2_of_2 first-column-child-margin">
                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="IME :"></dx:ASPxLabel>
                                        </div>
                                        <div class="content-field-full-width">
                                            <dx:ASPxTextBox ID="txtIme" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                                                ClientInstanceName="clientCode" MaxLength="50">
                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                <ClientSideEvents Init="SetFocus" />
                                            </dx:ASPxTextBox>
                                        </div>
                                    </div>
                                    <div class="col span_2_of_2">
                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                            <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="PRIIMEK :"></dx:ASPxLabel>
                                        </div>
                                        <div class="content-field-full-width">
                                            <dx:ASPxTextBox ID="txtPriimek" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                                                ClientInstanceName="clientName" MaxLength="50">
                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                            </dx:ASPxTextBox>
                                        </div>
                                    </div>
                                    <div class="col span_2_of_2">
                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                            <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="NASLOV :"></dx:ASPxLabel>
                                        </div>
                                        <div class="content-field-full-width">
                                            <dx:ASPxTextBox ID="txtNaslov" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                                                ClientInstanceName="clientName" MaxLength="100">
                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                            </dx:ASPxTextBox>
                                        </div>
                                    </div>
                                    <div class="col span_2_of_2">
                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                            <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="DAT. ROJSTVA :"></dx:ASPxLabel>
                                        </div>
                                        <div class="content-field-full-width">
                                            <dx:ASPxDateEdit ID="ASPxDateEditDatumRojstva" runat="server" Width="100px" Theme="MetropolisBlue"
                                                HorizontalAlign="right" CssClass="text-box-input" Font-Size="Small" PopupVerticalAlign="WindowCenter">
                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši"></CalendarProperties>
                                                <DropDownButton Visible="true"></DropDownButton>
                                            </dx:ASPxDateEdit>
                                        </div>
                                    </div>
                                    <div class="col span_2_of_2">
                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                            <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="UPO. IME :"></dx:ASPxLabel>
                                        </div>
                                        <div class="content-field-full-width">
                                            <dx:ASPxTextBox ID="txtUporabniskoIme" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                                                ClientInstanceName="clientUsername" MaxLength="50">
                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                            </dx:ASPxTextBox>
                                        </div>
                                    </div>
                                    <div class="col span_2_of_2">
                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                            <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="GESLO :"></dx:ASPxLabel>
                                        </div>
                                        <div class="content-field-full-width">
                                            <dx:ASPxTextBox ID="txtGesloVnos" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                                                ClientInstanceName="clientPassword" MaxLength="50">
                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                            </dx:ASPxTextBox>
                                        </div>
                                    </div>
                                    <div class="col span_2_of_2">
                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                            <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="DAT. ZAPOSLITVE :"></dx:ASPxLabel>
                                        </div>
                                        <div class="content-field-full-width">
                                            <dx:ASPxDateEdit ID="ASPxDateEditDatumZaposlitve" runat="server" Width="100px" Theme="MetropolisBlue"
                                                HorizontalAlign="right" CssClass="text-box-input" Font-Size="Small" PopupVerticalAlign="Above">
                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši"></CalendarProperties>
                                                <DropDownButton Visible="true"></DropDownButton>
                                            </dx:ASPxDateEdit>
                                        </div>
                                    </div>
                                    <div class="col span_2_of_2">
                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                            <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="DEL. MESTO :"></dx:ASPxLabel>
                                        </div>
                                        <div class="content-field-full-width">
                                            <dx:ASPxTextBox ID="txtDelovnoMesto" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                                                ClientInstanceName="clientName" MaxLength="50">
                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                            </dx:ASPxTextBox>
                                        </div>
                                    </div>
                                    <div class="col span_2_of_2">
                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                            <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="VLOGA :"></dx:ASPxLabel>
                                        </div>
                                        <div class="content-field-full-width">
                                            <dx:ASPxComboBox ID="ComboBoxVloga" runat="server" ValueType="System.String" DropDownStyle="DropDownList"
                                                IncrementalFilteringMode="StartsWith" TextField="Koda" ValueField="idVloga"
                                                EnableSynchronization="False" OnDataBinding="ComboBoxVloga_DataBinding"
                                                Font-Size="Small" CssClass="text-box-input" PopupVerticalAlign="Above">
                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                                    RequiredField-ErrorText="Enter valid value">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </div>
                                    </div>
                                    <div class="col span_2_of_2">
                                        <div class="content-form-element-label-flex lable-width-medium"></div>
                                        <div class="content-field-full-width"></div>
                                    </div>
                                </div>

                            </div>
                            <div class="userImage">
                                <div runat="server" class="clearIcon" id="clearImage"></div>
                                <div id="externalDropZone" class="alignCenter">

                                    <img runat="server" id="uploadedImage" src="/Images/Profile4.png" class="img-circle" alt="" width="150" height="150" />
                                </div>
                                <div class="alignCenter">
                                    <dx:ASPxUploadControl ID="ImageUploadControl" ClientInstanceName="clientImageUploadControl" runat="server" UploadMode="Auto"
                                        AutoStartUpload="True" Width="200px" ShowProgressPanel="True" CssClass="uploadControl" DialogTriggerID="externalDropZone"
                                        OnFileUploadComplete="UploadControl_FileUploadComplete"
                                        ShowUploadButton="true" ShowTextBox="false" Font-Size="Small">
                                        <UploadButton Text="Naloži" Image-SpriteProperties-CssClass="uploadProfileImgBtn"></UploadButton>
                                        <AdvancedModeSettings EnableMultiSelect="False" />
                                        <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg, .jpeg, .gif, .png" ErrorStyle-CssClass="validationMessage" />
                                        <BrowseButton Text="Dodaj" />

                                        <CancelButton Text="asd"></CancelButton>
                                        <ProgressBarStyle CssClass="uploadControlProgressBar" />
                                        <ClientSideEvents FileUploadComplete="onUploadControlFileUploadComplete"></ClientSideEvents>
                                    </dx:ASPxUploadControl>

                                    <dx:ASPxCallback runat="server" ID="ClearImageCallback" ClientInstanceName="clientClearImageCallback"
                                        OnCallback="ClearImageCallback_Callback">
                                        <ClientSideEvents CallbackComplete="ClearImageComplete" />
                                    </dx:ASPxCallback>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="contactInfoWrap">
                        <h2 class="titleUserDate small-margin-l">Kontaktni podatki</h2>
                        <div class="section group big-margin-b">
                            <div class="col span_2_of_2 first-column-child-margin">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="TELEFON :"></dx:ASPxLabel>
                                </div>
                                <div class="content-field-full-width">
                                    <dx:ASPxTextBox ID="txtTelefon" runat="server" Width="90%" Font-Size="Small" CssClass="text-box-input"
                                        ClientInstanceName="clientCode" MaxLength="50">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_2_of_2">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="E-POŠTA :"></dx:ASPxLabel>
                                </div>
                                <div class="content-field-full-width">
                                    <dx:ASPxTextBox ID="txtEmail" runat="server" Width="90%" Font-Size="Small" CssClass="text-box-input"
                                        ClientInstanceName="clientName" MaxLength="50">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="userInfoBtnSave">
                    <div class="AddEditButtonsWrap">
                        <div class="AddEditButtonsElements" style="margin-top: 10px;">
                            <span class="AddEditButtons">
                                <dx:ASPxButton ID="btnConfirm" runat="server" Text="Potrdi" OnClick="btnConfirm_Click" AutoPostBack="false"
                                    ValidationGroup="Confirm">
                                    <ClientSideEvents Click="CauseValidation" />
                                </dx:ASPxButton>
                            </span>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
</asp:Content>
