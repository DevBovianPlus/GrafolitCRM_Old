<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" Title="Urejanje dogodkov" AutoEventWireup="true" CodeBehind="EventsForm.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Events.EventsForm" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ MasterType VirtualPath="~/MasterPage.Master" %>

<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        function OnClosePopupEventHandler_Message(command) {
            switch (command) {
                case 'Potrdi':
                    clientPopUpMessage.Hide();
                    //gridMessage.Refresh();
                    clientMessageCallback.PerformCallback("RefreshGrid");
                    break;
                case 'Preklici':
                    clientPopUpMessage.Hide();
                    break;
            }
        }

        function PlanPopUpShow(s, e) {
            var parameter = "";
            parameter = HandleUserActionsOnTabs(gridMessage, clientBtnAdd, clientBtnEdit, clientBtnDelete, s);

            if (CheckValidData()) {
                //ShowSpinnerLoader();
                clientMessageCallback.PerformCallback(parameter);
            }
        }

        function CauseValidation(s, e) {
            var procees = false;


            if (clientBtnConfirm.GetText() == 'Izbrisi')
                procees = true;
            else
                procees = CheckValidData();

            if (procees)
                e.processOnServer = true;
            else
                e.processOnServer = false;
        }

        function CheckValidData() {
            var process = true;

            var lookupItems = [clientLookupIzvajalec, clientLookupStranke, clientComboBoxTip];
            var dateEditItems = [ASPxDateEditDatumOtvoritveClient];
            process = InputFieldsValidation(lookupItems, null, dateEditItems);

            return process;
        }

        function SaveDocument(s, e) {
            var process = true;

            procees = CheckValidData();//we are cheking this if we add new event and we don't save it first
            if (procees) {
                var elementName = s.name.substring(s.name.lastIndexOf('_') + 1, s.name.length);

                switch (elementName) {
                    case OddajPripravoBtn.name.substring(OddajPripravoBtn.name.lastIndexOf('_') + 1, OddajPripravoBtn.name.length):
                        if (InputFieldsValidation(null, null, null, [ASPxMemoPripravaSestanekClient]))
                            meetingCallbackPanelClient.PerformCallback("PRIPRAVA");
                        break;
                    case OddajPorociloBtn.name.substring(OddajPorociloBtn.name.lastIndexOf('_') + 1, OddajPorociloBtn.name.length):
                        if (InputFieldsValidation(null, null, null, [ASPxMemoPorociloSestanekClient]))
                            meetingCallbackPanelClient.PerformCallback("POROCILO");
                        break;
                }
            }
        }

        function onMeetingEntrySaved(s, e) {
            ASPxMemoPripravaSestanekClient.SetText("");
            ASPxMemoPorociloSestanekClient.SetText("");
            if (!gridSestanekClient.GetVisible())
                gridSestanekClient.SetVisible(true);

            $('#ctl00_ContentPlaceHolder2_ASPxRoundPanel1_ClientPageControl_idPorociloSection').css("display", "flex");

            gridSestanekClient.SetHeight(gridSestanekClient.GetHeight() + 50);
        }

        function textareaFocus(s, e) {
            $(s.GetInputElement()).parent().removeClass("focus-text-box-input-error");
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="false" Theme="MetropolisBlue"
        HeaderStyle-HorizontalAlign="Center" Font-Bold="true" Width="100%" HeaderText="Dogodki">
        <ContentPaddings PaddingBottom="7px" PaddingLeft="3px" PaddingRight="3px" PaddingTop="7px" />
        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxPageControl ID="ClientPageControl" runat="server" ActiveTabIndex="0" Theme="MetropolisBlue" Width="100%"
                    BackColor="#f8f8f8" ClientInstanceName="clientPageControl">
                    <TabPages>
                        <dx:TabPage Name="Basic" Text="OSNOVNI PODATKI">
                            <ContentCollection>
                                <dx:ContentControl BackColor="#f8f8f8">
                                    <div class="section group">
                                        <div class="col span_1_of_3 hide-block-important">
                                            <div class="content-form-element-label-flex lable-width-medium">
                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="ID :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtIdDogodek" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    ReadOnly="true" BackColor="LightGray">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 hide-block-important"></div>
                                        <div class="col span_1_of_3 no-margin-left-important">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="SKRBNIK :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxGridLookup ID="ASPxGridLookupIzvajalec" runat="server" KeyFieldName="idOsebe"
                                                    ClientInstanceName="clientLookupIzvajalec" OnDataBinding="ASPxGridLookupIzvajalec_DataBinding"
                                                    Theme="MetropolisBlue" SelectionMode="Single" TextFormatString="{1} {2}"
                                                    Width="180px" OnLoad="ASPxGridLookupLoad_WidthMedium" CssClass="text-box-input" Height="23px"
                                                    Paddings-PaddingTop="0" Paddings-PaddingBottom="0">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <GridViewStyles>
                                                        <Header CssClass="gridview-no-header-padding" ForeColor="Black"></Header>
                                                        <FilterBarClearButtonCell></FilterBarClearButtonCell>
                                                    </GridViewStyles>
                                                    <GridViewProperties>
                                                        <SettingsBehavior AllowDragDrop="False" EnableRowHotTrack="True"  />
                                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>
                                                        <SettingsPager ShowSeparators="True" AlwaysShowPager="True" ShowNumericButtons="true"></SettingsPager>
                                                        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowPreview="True" ShowVerticalScrollBar="True"
                                                            ShowHorizontalScrollBar="true" VerticalScrollableHeight="200"></Settings>
                                                    </GridViewProperties>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="Zaposleni Id" FieldName="idOsebe" Width="80px"
                                                            ReadOnly="true" Visible="false" ShowInCustomizationForm="True" VisibleIndex="0">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Ime" FieldName="Ime" Width="20%"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Priimek"
                                                            FieldName="Priimek" ShowInCustomizationForm="True"
                                                            VisibleIndex="2" Width="25%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Email"
                                                            FieldName="Email" ShowInCustomizationForm="True"
                                                            VisibleIndex="3" Width="30%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Delovno mesto"
                                                            FieldName="DelovnoMesto" ShowInCustomizationForm="True"
                                                            VisibleIndex="4" Width="25%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                    <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                                        RequiredField-ErrorText="Enter valid value">
                                                        <RequiredField IsRequired="true" />
                                                    </ValidationSettings>
                                                    <ClientSideEvents Init="SetFocus" />
                                                </dx:ASPxGridLookup>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3">
                                            <div class="content-form-element-label-flex lable-width-medium">
                                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="STRANKA :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxGridLookup ID="ASPxGridLookupStranke" runat="server" KeyFieldName="idStranka"
                                                    ClientInstanceName="clientLookupStranke" OnDataBinding="ASPxGridLookupStranke_DataBinding"
                                                    Theme="MetropolisBlue" SelectionMode="Single" TextFormatString="{2} {3}"
                                                    Width="180px" OnLoad="ASPxGridLookupLoad_WidthLarge" CssClass="text-box-input" Height="23px">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <GridViewStyles>
                                                        <FilterBarClearButtonCell></FilterBarClearButtonCell>
                                                    </GridViewStyles>
                                                    <GridViewProperties>
                                                        <SettingsBehavior AllowDragDrop="False" EnableRowHotTrack="True" />
                                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>
                                                        <SettingsPager ShowSeparators="True" AlwaysShowPager="True" ShowNumericButtons="true"></SettingsPager>
                                                        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowVerticalScrollBar="True"
                                                            ShowHorizontalScrollBar="true" VerticalScrollableHeight="200"></Settings>
                                                    </GridViewProperties>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="Zaposleni Id" FieldName="idStranka" Width="80px"
                                                            ReadOnly="true" Visible="false" ShowInCustomizationForm="True" VisibleIndex="0">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Stranke Id" FieldName="KodaStranke" Width="80px"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Naziv Prvi"
                                                            FieldName="NazivPrvi" ShowInCustomizationForm="True"
                                                            VisibleIndex="2" Width="150px">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Naziv drugi"
                                                            FieldName="NazivDrugi" ShowInCustomizationForm="True"
                                                            VisibleIndex="3" Width="150px">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Naslov"
                                                            FieldName="Naslov" ShowInCustomizationForm="True"
                                                            VisibleIndex="4" Width="200px">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Email"
                                                            FieldName="Email" ShowInCustomizationForm="True"
                                                            VisibleIndex="7" Width="200px">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridLookup>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_right_column_content">
                                            <div class="content-form-element-label-flex lable-width-large">
                                                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="KATEGORIJA :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxGridLookup ID="ASPxGridLookupKategorije" runat="server" KeyFieldName="idKategorija"
                                                    ClientInstanceName="clientLookupKategorija" OnDataBinding="ASPxGridLookupKategorije_DataBinding"
                                                    Theme="MetropolisBlue" SelectionMode="Single" TextFormatString="{1}"
                                                    Width="180px" OnLoad="ASPxGridLookupLoad_WidthSmall" CssClass="text-box-input" Height="23px">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <GridViewStyles>
                                                        <FilterBarClearButtonCell></FilterBarClearButtonCell>
                                                    </GridViewStyles>
                                                    <GridViewProperties>
                                                        <SettingsBehavior AllowDragDrop="False" EnableRowHotTrack="True" />
                                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>
                                                        <SettingsPager ShowSeparators="True" AlwaysShowPager="True" ShowNumericButtons="false"></SettingsPager>
                                                        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowVerticalScrollBar="True"
                                                            ShowHorizontalScrollBar="true" VerticalScrollableHeight="140"></Settings>
                                                    </GridViewProperties>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="Kategorija Id" FieldName="idKategorija" Width="80px"
                                                            ReadOnly="true" Visible="false" ShowInCustomizationForm="True" VisibleIndex="0">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Koda" FieldName="Koda" Width="30%"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Naziv"
                                                            FieldName="Naziv" ShowInCustomizationForm="True"
                                                            VisibleIndex="2" Width="70%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridLookup>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 no-margin-left-important">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="OTVORITEV :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxDateEdit ID="ASPxDateEditDatumOtvoritve" runat="server" Width="100px" Theme="MetropolisBlue"
                                                    HorizontalAlign="right" CssClass="text-box-input" Font-Size="Small"
                                                    ClientInstanceName="ASPxDateEditDatumOtvoritveClient">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši"></CalendarProperties>
                                                    <DropDownButton Visible="true"></DropDownButton>
                                                </dx:ASPxDateEdit>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3">
                                            <div class="content-form-element-label-flex lable-width-medium">
                                                <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="ROK :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxDateEdit ID="ASPxDateEditDatumRok" runat="server" Width="100px" Theme="MetropolisBlue"
                                                    HorizontalAlign="right" CssClass="text-box-input" Font-Size="Small">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši"></CalendarProperties>
                                                    <DropDownButton Visible="true"></DropDownButton>
                                                </dx:ASPxDateEdit>
                                            </div>
                                        </div>

                                        <div class="col span_1_of_3 align_right_column_content column-tiny-padding-top-mobile tiny-paddin-top">
                                            <div class="content-form-element-label-flex lable-width-large">
                                                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="STATUS :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxGridLookup ID="ASPxGridLookupStatus" runat="server" KeyFieldName="idStatusDogodek"
                                                    ClientInstanceName="clientLookupStatus" OnDataBinding="ASPxGridLookupStatus_DataBinding"
                                                    Theme="MetropolisBlue" SelectionMode="Single" TextFormatString="{1}"
                                                    Width="180px" OnLoad="ASPxGridLookupLoad_WidthSmall" CssClass="text-box-input" Height="23px">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <GridViewStyles>
                                                        <FilterBarClearButtonCell></FilterBarClearButtonCell>
                                                    </GridViewStyles>
                                                    <GridViewProperties>
                                                        <SettingsBehavior AllowDragDrop="False" EnableRowHotTrack="True" />
                                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>
                                                        <SettingsPager ShowSeparators="True" AlwaysShowPager="True" ShowNumericButtons="true"></SettingsPager>
                                                        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowVerticalScrollBar="True"
                                                            ShowHorizontalScrollBar="true" VerticalScrollableHeight="140"></Settings>
                                                    </GridViewProperties>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="Status Id" FieldName="idStatusDogodek" Width="80px"
                                                            ReadOnly="true" Visible="false" ShowInCustomizationForm="True" VisibleIndex="0">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Koda" FieldName="Koda" Width="20%"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Naziv"
                                                            FieldName="Naziv" ShowInCustomizationForm="True"
                                                            VisibleIndex="2" Width="80%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridLookup>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 no-margin-left-important column-small-padding-top-mobile">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="ROK IZVEDBE :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxDateEdit ID="ASPxDateEditDatumRokIzvedbe" runat="server" Width="100px" Theme="MetropolisBlue"
                                                    HorizontalAlign="right" CssClass="text-box-input" Font-Size="Small">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši"></CalendarProperties>
                                                    <DropDownButton Visible="true"></DropDownButton>
                                                </dx:ASPxDateEdit>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3">
                                            <div class="content-form-element-label-flex lable-width-medium">
                                                <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="TIP :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxComboBox ID="ComboBoxTipDogodka" runat="server" ValueType="System.String" DropDownStyle="DropDownList"
                                                    IncrementalFilteringMode="StartsWith" TextField="CelotnoIme" ValueField="idOsebe"
                                                    EnableSynchronization="False"
                                                    CssClass="text-box-input" ClientInstanceName="clientComboBoxTip">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <Items>
                                                        <dx:ListEditItem Text="Moj dogodek" Value="Moj dogodek" />
                                                        <dx:ListEditItem Text="Avtomatika" Value="Avtomatika" />
                                                        <dx:ListEditItem Text="Samodejni dogodek" Value="Samodejni dogodek" />
                                                        <dx:ListEditItem Text="Drugo" Value="Drugo" />
                                                    </Items>
                                                </dx:ASPxComboBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_right_column_content">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="DATUM ZAD. ZAPRTJA :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtDatumZadnjegaZaprtja" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    MaxLength="10">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_3_of_3 no-margin-left-important big-margin-b">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="NASLOV :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-field-full-width">
                                                <dx:ASPxMemo ID="ASPxMemoOpis" runat="server" Width="100%" MaxLength="2000" Theme="Moderno"
                                                    NullText="Ime dogodka..." Rows="1" HorizontalAlign="Left" BackColor="White"
                                                    CssClass="text-box-input">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxMemo>
                                            </div>
                                        </div>
                                    </div>

                                    <%-- For styling we must this hidden lookup move out from grid div --%>
                                    <div class="col span_1_of_3" style="display: none;">
                                        <div class="content-form-element-label-flex">
                                            <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="SKRBNIK :" Visible="false"></dx:ASPxLabel>
                                        </div>
                                        <div class="content-input-filed">
                                            <dx:ASPxGridLookup ID="ASPxGridLookupSkrbnik" runat="server" KeyFieldName="idOsebe"
                                                ClientInstanceName="clientLookupSkrbnik" OnDataBinding="ASPxGridLookupSkrbnik_DataBinding"
                                                Theme="MetropolisBlue" SelectionMode="Single" TextFormatString="{1} {2}"
                                                Width="180px" OnLoad="ASPxGridLookupLoad_WidthMedium" CssClass="text-box-input" Height="23px"
                                                Visible="false">
                                                <%-- Usage in javascript - method CheckValidData --%>
                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                <GridViewStyles>
                                                    <FilterBarClearButtonCell></FilterBarClearButtonCell>
                                                </GridViewStyles>
                                                <GridViewProperties>
                                                    <SettingsBehavior AllowDragDrop="False" EnableRowHotTrack="True" />
                                                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True"></SettingsBehavior>
                                                    <SettingsPager ShowSeparators="True" AlwaysShowPager="True" PageSize="100" ShowNumericButtons="false"></SettingsPager>
                                                    <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowPreview="True" ShowVerticalScrollBar="True"
                                                        ShowStatusBar="Visible" VerticalScrollBarStyle="Virtual" ShowHorizontalScrollBar="true" VerticalScrollableHeight="140"></Settings>
                                                </GridViewProperties>
                                                <Columns>
                                                    <dx:GridViewDataTextColumn Caption="Zaposleni Id" FieldName="idOsebe" Width="80px"
                                                        ReadOnly="true" Visible="false" ShowInCustomizationForm="True" VisibleIndex="0">
                                                    </dx:GridViewDataTextColumn>

                                                    <dx:GridViewDataTextColumn Caption="Ime" FieldName="Ime" Width="80px"
                                                        ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1">
                                                    </dx:GridViewDataTextColumn>

                                                    <dx:GridViewDataTextColumn Caption="Priimek"
                                                        FieldName="Priimek" ShowInCustomizationForm="True"
                                                        VisibleIndex="2" Width="150px">
                                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="Email"
                                                        FieldName="Email" ShowInCustomizationForm="True"
                                                        VisibleIndex="3" Width="150px">
                                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="Delovno mesto"
                                                        FieldName="DelovnoMesto" ShowInCustomizationForm="True"
                                                        VisibleIndex="4" Width="200px">
                                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                                <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                                    RequiredField-ErrorText="Enter valid value">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxGridLookup>
                                        </div>
                                    </div>
                                    <dx:ASPxCallbackPanel ID="MessageCallback" runat="server" ClientInstanceName="clientMessageCallback"
                                        OnCallback="MessageCallback_Callback" Visible="false">
                                        <PanelCollection>
                                            <dx:PanelContent>
                                                <dx:ASPxHeadline ID="ASPxHeadline1" runat="server" HeaderText="SPOROČILA">
                                                </dx:ASPxHeadline>
                                                <dx:ASPxGridView ID="ASPxGridViewMessage" runat="server" AutoGenerateColumns="False"
                                                    EnableTheming="True" EnableCallbackCompression="true" ClientInstanceName="gridMessage"
                                                    Theme="Moderno" Width="100%" KeyboardSupport="true" AccessKey="G"
                                                    KeyFieldName="idSporocila" OnDataBinding="ASPxGridViewMessage_DataBinding"
                                                    Paddings-PaddingTop="0" Paddings-PaddingBottom="0"
                                                    CssClass="gridview-no-header-padding">
                                                    <ClientSideEvents RowDblClick="PlanPopUpShow" />
                                                    <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="150"
                                                        ShowHorizontalScrollBar="True" ShowFilterBar="Auto" ShowFilterRow="True"
                                                        ShowFilterRowMenu="True" VerticalScrollBarStyle="Standard" />
                                                    <SettingsPager PageSize="10" ShowNumericButtons="true">
                                                        <PageSizeItemSettings Visible="true" Items="10,20,30" Caption="Zapisi na stran : " AllItemText="Vsi">
                                                        </PageSizeItemSettings>
                                                        <Summary Visible="true" Text="Vseh zapisov : {2}" />
                                                    </SettingsPager>
                                                    <SettingsBehavior AllowFocusedRow="true" />
                                                    <Styles Header-Wrap="True">
                                                        <Header Paddings-PaddingTop="5" HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="true"></Header>
                                                        <FocusedRow BackColor="#d1e6fe" Font-Bold="true" ForeColor="#606060"></FocusedRow>
                                                    </Styles>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="ID" FieldName="idSporocila" Width="100px"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Dogodek ID"
                                                            FieldName="IDDogodek" ShowInCustomizationForm="True"
                                                            VisibleIndex="2" Width="100px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Opis"
                                                            FieldName="OpisDel" ShowInCustomizationForm="True"
                                                            VisibleIndex="3" Width="87%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataDateColumn Caption="Datum vpisa"
                                                            FieldName="ts" ShowInCustomizationForm="True"
                                                            VisibleIndex="4" Width="13%">
                                                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy - HH:mm"></PropertiesDateEdit>
                                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataTextColumn Caption="Oseba vnosa"
                                                            FieldName="tsIDOsebe" ShowInCustomizationForm="True"
                                                            VisibleIndex="5" Width="115px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                                <dx:ASPxPopupControl ID="ASPxPopupControl_Message" runat="server" ContentUrl="Message_popup.aspx"
                                                    ClientInstanceName="clientPopUpMessage" Modal="True" HeaderText="DODAJ SPOROČILO"
                                                    Theme="MetropolisBlue" CloseAction="CloseButton" Width="620px" Height="345px" PopupHorizontalAlign="WindowCenter"
                                                    PopupVerticalAlign="WindowCenter" PopupAnimationType="Fade" AllowDragging="true" ShowSizeGrip="true"
                                                    AllowResize="true">
                                                    <ContentStyle BackColor="#F7F7F7">
                                                        <Paddings PaddingBottom="0px" PaddingLeft="6px" PaddingRight="0px" PaddingTop="0px"></Paddings>
                                                    </ContentStyle>
                                                    <ContentCollection>
                                                        <dx:PopupControlContentControl ID="PopUpContentControl" runat="server">
                                                        </dx:PopupControlContentControl>
                                                    </ContentCollection>
                                                </dx:ASPxPopupControl>
                                                <div class="AddEditButtonsWrap">

                                                    <div class="extraBtnsForGrid">
                                                        <div class="AddEditButtonsElements">
                                                            <span class="AddEditButtons">
                                                                <dx:ASPxButton ID="btnAddMessage" runat="server" Text="Dodaj" AutoPostBack="false"
                                                                    Height="25" Width="90" ClientInstanceName="clientBtnAdd" ValidationGroup="Confirm">
                                                                    <ClientSideEvents Click="PlanPopUpShow" />
                                                                    <Image Url="../../../Images/addForPopUp.png"></Image>
                                                                </dx:ASPxButton>
                                                            </span>
                                                            <span class="AddEditButtons">
                                                                <dx:ASPxButton ID="btnEditMessage" runat="server" Text="Spremeni" AutoPostBack="false"
                                                                    Height="25" Width="90" ClientInstanceName="clientBtnEdit">
                                                                    <ClientSideEvents Click="PlanPopUpShow" />
                                                                    <Image Url="../../../Images/editForPopup.png"></Image>
                                                                </dx:ASPxButton>
                                                            </span>
                                                            <span class="AddEditButtons">
                                                                <dx:ASPxButton ID="btnDeleteMessage" runat="server" Text="Izbriši" AutoPostBack="false"
                                                                    Height="25" Width="90" ClientInstanceName="clientBtnDelete">
                                                                    <ClientSideEvents Click="PlanPopUpShow" />
                                                                    <Image Url="../../../Images/trashForPopUp.png"></Image>
                                                                </dx:ASPxButton>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>
                                    <dx:ASPxCallbackPanel runat="server" ID="CallbackPanelMeeting" ClientInstanceName="meetingCallbackPanelClient"
                                        OnCallback="CallbackPanelMeeting_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>
                                                <dx:ASPxHeadline ID="ASPxHeadline2" runat="server" HeaderText="PRIPRAVE IN POROČILA">
                                                </dx:ASPxHeadline>
                                                <dx:ASPxGridView ID="ASPxGridView_Sestanek" runat="server" Width="100%"
                                                    KeyFieldName="DogodekSestanekID" OnDataBinding="ASPxGridView_Sestanek_DataBinding"
                                                    ClientInstanceName="gridSestanekClient" OnHtmlRowPrepared="ASPxGridView_Sestanek_HtmlRowPrepared"
                                                    Paddings-PaddingTop="0" Paddings-PaddingBottom="0" Visible="false">

                                                    <SettingsPager Mode="ShowAllRecords" />
                                                    <SettingsBehavior AllowSort="false" AllowGroup="false" />
                                                    <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="250"
                                                        VerticalScrollBarStyle="Standard" />
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="Datum"
                                                            FieldName="Datum" ShowInCustomizationForm="True"
                                                            Width="13%">
                                                            <Settings AllowAutoFilter="False" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Opis"
                                                            FieldName="Opis" ShowInCustomizationForm="True"
                                                            Width="87%">
                                                            <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="ime" FieldName="ImeInPriimekOsebe"
                                                            Visible="false">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="ime" FieldName="Tip"
                                                            Visible="false">
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                    <Templates>
                                                        <DetailRow>
                                                            <%-- Dodaj polje kdo je dodal zapis, kakšen tip zapisa je, itd. --%>
                                                            <span style="width: 40px; display: inline-block;">Oddal:</span>
                                                            <dx:ASPxLabel runat="server" Text='<%# Eval("ImeInPriimekOsebe") %>' Font-Bold="true"></dx:ASPxLabel>
                                                            <br />
                                                            <span style="width: 40px; display: inline-block;">Tip:</span>
                                                            <dx:ASPxLabel runat="server" Text='<%# Eval("Tip") %>' Font-Bold="true"></dx:ASPxLabel>
                                                        </DetailRow>
                                                    </Templates> 
                                                    <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="true" />
                                                </dx:ASPxGridView>

                                                <div class="section group">
                                                    <div id="idPripravaSection" class="col span_3_of_3 no-margin-left-important" runat="server">
                                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                                            <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="PRIPRAVA :"></dx:ASPxLabel>
                                                        </div>
                                                        <div class="content-field-full-width">
                                                            <dx:ASPxMemo ID="ASPxMemoPripravaSestanek" runat="server" Width="100%" MaxLength="2000" Theme="Moderno"
                                                                NullText="Priprava sestanka..." Rows="4" HorizontalAlign="Left" BackColor="AliceBlue"
                                                                CssClass="text-box-input" ClientInstanceName="ASPxMemoPripravaSestanekClient">
                                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                                <ClientSideEvents GotFocus="textareaFocus" />
                                                            </dx:ASPxMemo>
                                                        </div>
                                                        <div class="big-margin-l">
                                                            <dx:ASPxButton runat="server" ID="PotrdiPripravoBtn" Text="Oddaj pripravo" AutoPostBack="false"
                                                                Height="30" Width="100" ClientInstanceName="OddajPripravoBtn">
                                                                <Image Url="../../../Images/PripravaSestanek.png"></Image>
                                                                <ClientSideEvents Click="SaveDocument" />
                                                            </dx:ASPxButton>
                                                        </div>
                                                    </div>
                                                    <div id="idPorociloSection" class="col span_3_of_3 no-margin-left-important" style="display: none;" runat="server">
                                                        <div class="content-form-element-label-flex lable-width-xtra-large">
                                                            <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="POROČILO :"></dx:ASPxLabel>
                                                        </div>
                                                        <div class="content-field-full-width">
                                                            <dx:ASPxMemo ID="ASPxMemoPorociloSestanek" runat="server" Width="100%" MaxLength="2000" Theme="Moderno"
                                                                NullText="Poročilo sestanka..." Rows="4" HorizontalAlign="Left" BackColor="AntiqueWhite"
                                                                CssClass="text-box-input" ClientInstanceName="ASPxMemoPorociloSestanekClient">
                                                                <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                                <ClientSideEvents GotFocus="textareaFocus" />
                                                            </dx:ASPxMemo>
                                                        </div>
                                                        <div class="big-margin-l">
                                                            <dx:ASPxButton runat="server" ID="ASPxButton1" Text="Oddaj poročilo" AutoPostBack="false"
                                                                Height="30" Width="100" ClientInstanceName="OddajPorociloBtn">
                                                                <Image Url="../../../Images/PorociloSestanek.png"></Image>
                                                                <ClientSideEvents Click="SaveDocument" />
                                                            </dx:ASPxButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                        <ClientSideEvents EndCallback="onMeetingEntrySaved" />
                                    </dx:ASPxCallbackPanel>
                                    <div class="AddEditButtonsWrap">
                                        <div class="AddEditButtonsElements clearFloatBtns">
                                            <span class="AddEditButtons">
                                                <dx:ASPxButton ID="btnConfirm" runat="server" Text="Potrdi" AutoPostBack="false" OnClick="btnConfirm_Click"
                                                    Height="30" Width="100" ValidationGroup="Confirm" ClientInstanceName="clientBtnConfirm">
                                                    <ClientSideEvents Click="CauseValidation" />
                                                </dx:ASPxButton>
                                            </span>
                                            <span class="AddEditButtons">
                                                <dx:ASPxButton ID="btnCancel" runat="server" Text="Preklici" AutoPostBack="false" OnClick="btnCancel_Click"
                                                    Height="30" Width="100">
                                                    <Image Url="../../../Images/cancel1.png"></Image>
                                                </dx:ASPxButton>
                                            </span>
                                        </div>
                                    </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                    </TabPages>
                </dx:ASPxPageControl>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
    <script type="text/javascript" src="../../../Scripts/ChromeFix_14.js"></script>
</asp:Content>
