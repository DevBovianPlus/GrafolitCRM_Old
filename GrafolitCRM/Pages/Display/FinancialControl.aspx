<%@ Page Title="Nadzor financ" Language="C#" MasterPageFile="~/HelloMasterPage.Master" AutoEventWireup="true" CodeBehind="FinancialControl.aspx.cs" Inherits="AnalizaProdaje.Pages.Display.FinancialControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<meta http-equiv="refresh" content="3600" />--%>

    <script type="text/javascript">
        function PrepareTimeValue(value) {
            if (value < 10)
                value = "0" + value;
            return value;
        }
        function UpdateTime(s, e) {
            var dateTime = new Date();
            var timeString = PrepareTimeValue(dateTime.getHours()) + ":" + PrepareTimeValue(dateTime.getMinutes()) + ":" +
                PrepareTimeValue(dateTime.getSeconds());
            timeLabel.SetText(timeString);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div>
        <div class="section group">
            <div class="col span_1_of_2_financial_control no-margin-left-important">
                <div class="content-form-element-label-flex">
                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Nazadnje posodobljeno: " Font-Size="Smaller" CssClass="font-raleway-light"></dx:ASPxLabel>
                </div>
                <div class="content-form-element-label-flex">
                    <dx:ASPxLabel ID="LastPageUpdate" runat="server" Text="" Font-Size="Smaller" Font-Bold="true"></dx:ASPxLabel>
                </div>
            </div>
            <div class="col span_1_of_2_financial_control align_right_column_content">
                <div class="content-form-element-label-flex">
                    <div class="content-form-element-label-flex">
                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Ura: " Font-Size="Smaller" CssClass="font-raleway-light"></dx:ASPxLabel>
                    </div>
                    <dx:ASPxTimer runat="server" ID="Timer" ClientInstanceName="timer" Interval="1000">
                        <ClientSideEvents Init="UpdateTime" Tick="UpdateTime" />
                    </dx:ASPxTimer>
                    <dx:ASPxLabel runat="server" ID="TimeLabel" ClientInstanceName="timeLabel" Font-Bold="true"
                        Font-Size="Smaller">
                    </dx:ASPxLabel>
                </div>
            </div>
            <div class="col span_3_of_3_financial_control no-margin-left-important" style="width:100%; margin-top:0;">
                <hr class="financial-control-rule no-margin-top" />
            </div>
            <div class="col span_3_of_3_financial_control align_center_column_content">
                <h1 style="font-size:35px; text-transform:uppercase;" class="font-raleway-light">Nadzor financ</h1>
            </div>
        </div>
        <div class="financial-control-wrap big-margin-top big-margin-b">
            <div class="section group text-box-input" style="background-color:#ffffff; padding:10px;">
                <div class="col span_3_of_3_financial_control align_center_column_content big-margin-b">
                    <img src="../../Images/logoGrafoLit.png" alt="grafolit" width="150" height="55" />
                </div>
                <div class="col span_1_of_3_financial_control no-margin-left-important">
                    <div class="content-input-field-financial-control">
                        <dx:ASPxTextBox ID="txtDobavitelji" runat="server" Width="100%"
                            Caption="Dobavitelji" CaptionSettings-Position="Top" ReadOnly="true" CaptionCellStyle-CssClass="font-raleway-light"
                            CssClass="text-box-input input-field-font-size" Font-Bold="true">
                            <FocusedStyle CssClass="focus-text-box-input" />
                            <ClientSideEvents Init="SetFocus" />
                        </dx:ASPxTextBox>
                        <img id="imgDobavitelji" runat="server" class="arrow" src="../../Images/arrowNeutral.png" />
                    </div>
                </div>

                <div class="col span_1_of_3_financial_control align_center_column_content">
                    <div class="content-input-field-financial-control">
                        <dx:ASPxTextBox ID="txtZaloga" runat="server" Width="100%"
                            Caption="Zaloga" CaptionSettings-Position="Top" ReadOnly="true" CaptionCellStyle-CssClass="font-raleway-light"
                            CssClass="text-box-input input-field-font-size" Font-Bold="true">
                            <FocusedStyle CssClass="focus-text-box-input" />
                        </dx:ASPxTextBox>
                        <img id="imgZaloga" runat="server" class="arrow" src="../../Images/arrowNeutral.png" />
                    </div>
                </div>

                <div class="col span_1_of_3_financial_control align_right_column_content">
                    <div class="content-input-field-financial-control">
                        <dx:ASPxTextBox ID="txtKupci" runat="server" Width="100%"
                            Caption="Kupci" CaptionSettings-Position="Top" ReadOnly="true" CaptionCellStyle-CssClass="font-raleway-light"
                            CssClass="text-box-input input-field-font-size" Font-Bold="true">
                            <FocusedStyle CssClass="focus-text-box-input" />
                        </dx:ASPxTextBox>
                        <img id="imgKupci" runat="server" class="arrow" src="../../Images/arrowNeutral.png" />
                    </div>
                </div>

                <div class="col span_1_of_3_financial_control no-margin-left-important">
                    <div class="content-input-field-financial-control">
                        <dx:ASPxTextBox ID="txtStDniDobavitelji" runat="server" Width="100%"
                            Caption="Št. dni - dobavitelji" CaptionSettings-Position="Top" ReadOnly="true" CaptionCellStyle-CssClass="font-raleway-light"
                            CssClass="text-box-input input-field-font-size" Font-Bold="true">
                            <FocusedStyle CssClass="focus-text-box-input" />
                        </dx:ASPxTextBox>
                        <img id="imgStDniDobavitelji" runat="server" class="arrow" src="../../Images/arrowNeutral.png" />
                    </div>
                </div>

                <div class="col span_1_of_3_financial_control align_center_column_content">
                    <div class="content-input-field-financial-control">
                        <dx:ASPxTextBox ID="txtInvesticije" runat="server" Width="100%"
                            Caption="Investicije" CaptionSettings-Position="Top" ReadOnly="true" CaptionCellStyle-CssClass="font-raleway-light"
                            CssClass="text-box-input input-field-font-size" Font-Bold="true">
                            <FocusedStyle CssClass="focus-text-box-input" />
                        </dx:ASPxTextBox>
                       <img id="imgInvesticije" runat="server" class="arrow hidden" src="../../Images/arrowNeutral.png" /> 
                    </div>
                </div>

                <div class="col span_1_of_3_financial_control align_right_column_content">
                    <div class="content-input-field-financial-control">
                        <dx:ASPxTextBox ID="txtStDniKupci" runat="server" Width="100%"
                            Caption="Št. dni - kupci" CaptionSettings-Position="Top" ReadOnly="true" CaptionCellStyle-CssClass="font-raleway-light"
                            CssClass="text-box-input input-field-font-size" Font-Bold="true">
                            <FocusedStyle CssClass="focus-text-box-input" />
                        </dx:ASPxTextBox>
                        <img id="imgStDniKupci" runat="server" class="arrow" src="../../Images/arrowNeutral.png" />
                    </div>
                </div>

                <div class="col span_3_of_3_financial_control align_center_column_content">
                    <div class="content-input-field-financial-control parent-full-width">
                        <dx:ASPxTextBox ID="txtInvesticijskoVzdrzevanje" runat="server" Width="100%"
                            Caption="Investicijsko vzdrževanje" CaptionSettings-Position="Top" ReadOnly="true" CaptionCellStyle-CssClass="font-raleway-light"
                            CssClass="text-box-input input-field-font-size big-margin-r" Font-Bold="true">
                            <FocusedStyle CssClass="focus-text-box-input" />
                        </dx:ASPxTextBox>
                        <img id="imgInvestVzdrze" runat="server" class="arrow hidden" src="../../Images/arrowNeutral.png" />
                    </div>
                </div>

                <div class="col span_1_of_3_financial_control no-margin-left-important"></div>
                <div class="col span_1_of_3_financial_control align_center_column_content">
                    <div class="content-input-field-financial-control">
                        <dx:ASPxTextBox ID="txtKrediti" runat="server" Width="100%"
                            Caption="Krediti" CaptionSettings-Position="Top" ReadOnly="true" CaptionCellStyle-CssClass="font-raleway-light"
                            CssClass="text-box-input input-field-font-size" Font-Bold="true">
                            <FocusedStyle CssClass="focus-text-box-input" />
                        </dx:ASPxTextBox>
                        <img id="imgKrediti" runat="server" class="arrow" src="../../Images/arrowNeutral.png" />
                    </div>
                </div>
                <div class="col span_1_of_3_financial_control align_right_column_content">
                    <div class="content-input-field-financial-control">
                        <dx:ASPxTextBox ID="txtSkupaj" runat="server" Width="100%"
                            Caption="Skupaj" CaptionSettings-Position="Top" ReadOnly="true" CaptionCellStyle-CssClass="font-raleway-light"
                            CssClass="text-box-input input-field-font-size" Font-Bold="true">
                            <FocusedStyle CssClass="focus-text-box-input" />
                        </dx:ASPxTextBox>
                        <img id="imgSkupaj" runat="server" class="arrow" src="../../Images/arrowNeutral.png" />
                    </div>
                </div>

                <div class="col span_3_of_3_financial_control align_center_column_content">
                    <div class="content-input-field-financial-control parent-full-width">
                        <dx:ASPxTextBox ID="txtDobicek" runat="server" Width="100%"
                            Caption="Dobiček" CaptionSettings-Position="Top" ReadOnly="true" CaptionCellStyle-CssClass="font-raleway-light"
                            CssClass="text-box-input input-field-font-size" Font-Bold="true">
                            <FocusedStyle CssClass="focus-text-box-input" />
                        </dx:ASPxTextBox>
                        <img id="imgDobicek" runat="server" class="arrow" src="../../Images/arrowNeutral.png" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
