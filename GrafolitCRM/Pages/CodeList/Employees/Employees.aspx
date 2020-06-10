<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" Title="Zaposleni" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Employees.Employees" %>

<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function OnClosePopupEventHandler_Employee(command) {
            switch (command) {
                case 'Potrdi':
                    clientPopUpEmployee.Hide();
                    //gridMessage.Refresh();
                    clientEmployeeCallback.PerformCallback("RefreshGrid");
                    break;
                case 'Preklici':
                    clientPopUpEmployee.Hide();
                    break;
            }
        }

        function PlanPopUpShow(s, e) {
            var parameter = "";
            parameter = HandleUserActionsOnTabs(gridEmployee, clientBtnAdd, clientBtnEdit, clientBtnDelete, s);
            clientEmployeeCallback.PerformCallback(parameter);
        }
    </script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" ShowCollapseButton="false" runat="server" Theme="MetropolisBlue"
        HeaderStyle-HorizontalAlign="Center" Font-Bold="true" Width="100%" HeaderText="Zaposleni">
        <ContentPaddings PaddingBottom="7px" PaddingLeft="3px" PaddingRight="3px" PaddingTop="7px" />
        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxCallbackPanel ID="EmployeeCallback" runat="server" ClientInstanceName="clientEmployeeCallback" OnCallback="EmployeeCallback_Callback">
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxGridView ID="ASPxGridViewZaposleni" runat="server" AutoGenerateColumns="False"
                                EnableTheming="True" EnableCallbackCompression="true"
                                Theme="Moderno" Width="100%" KeyboardSupport="true" AccessKey="G"
                                OnDataBinding="ASPxGridViewZaposleni_DataBinding"
                                KeyFieldName="idOsebe" Paddings-PaddingTop="0" Paddings-PaddingBottom="0"
                                ClientInstanceName="gridEmployee" CssClass="gridview-no-header-padding" >
                                <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="400"
                                    ShowHorizontalScrollBar="True" ShowFilterBar="Auto" ShowFilterRow="True"
                                    ShowFilterRowMenu="True" VerticalScrollBarStyle="Standard" />
                                <ClientSideEvents RowDblClick="PlanPopUpShow" />
                                <SettingsPager PageSize="10" ShowNumericButtons="true">
                                    <PageSizeItemSettings Visible="true" Items="10,20,30" Caption="Zapisi na stran : " AllItemText="Vsi">
                                    </PageSizeItemSettings>
                                    <Summary Visible="true" Text="Vseh zapisov : {2}" EmptyText="Ni zapisov"/>                          
                                </SettingsPager>
                                <SettingsBehavior AllowFocusedRow="true" />
                                <Styles Header-Wrap="True">
                                    <Header Paddings-PaddingTop="5" HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="true"></Header>
                                    <FocusedRow BackColor="#d1e6fe" Font-Bold="true" ForeColor="#606060"></FocusedRow>
                                </Styles>

                                <Columns>
                                    <dx:GridViewDataTextColumn Caption="Zaposleni Id" FieldName="idOsebe" Width="80px"
                                        ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataTextColumn Caption="Ime"
                                        FieldName="Ime" ShowInCustomizationForm="True"
                                        VisibleIndex="2" Width="20%">
                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Priimek"
                                        FieldName="Priimek" ShowInCustomizationForm="True"
                                        VisibleIndex="3" Width="20%">
                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Naslov"
                                        FieldName="Naslov" ShowInCustomizationForm="True"
                                        VisibleIndex="4" Width="24%">
                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Telefon"
                                        FieldName="TelefonGSM" ShowInCustomizationForm="True"
                                        VisibleIndex="5" Width="14%">
                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn Caption="Datum rojstva"
                                        FieldName="DatumRojstva" ShowInCustomizationForm="True"
                                        VisibleIndex="6" Width="90px" Visible="false">
                                        <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy"></PropertiesDateEdit>
                                        <CellStyle HorizontalAlign="Right"></CellStyle>
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataTextColumn Caption="Email"
                                        FieldName="Email" ShowInCustomizationForm="True"
                                        VisibleIndex="7" Width="22%">
                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn Caption="Datum zaposlitve"
                                        FieldName="DatumZaposlitve" ShowInCustomizationForm="True"
                                        VisibleIndex="8" Width="105px" Visible="false">
                                        <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy"></PropertiesDateEdit>
                                        <CellStyle HorizontalAlign="Right"></CellStyle>
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataTextColumn Caption="Delovno mesto"
                                        FieldName="DelovnoMesto" ShowInCustomizationForm="True"
                                        VisibleIndex="9" Width="150px" Visible="false">
                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataComboBoxColumn Caption="Zunanji" FieldName="Zunanji"
                                        ShowInCustomizationForm="True" Width="80px" VisibleIndex="10" Visible="false">
                                        <PropertiesComboBox Spacing="0" ValueType="System.String">
                                            <Items>
                                                <dx:ListEditItem Text="DA" Value="1" />
                                                <dx:ListEditItem Text="NE" Value="0" />
                                            </Items>
                                        </PropertiesComboBox>
                                    </dx:GridViewDataComboBoxColumn>
                                </Columns>
                            </dx:ASPxGridView>
                            <dx:ASPxPopupControl ID="ASPxPopupControl_Employee" runat="server" ContentUrl="Employee_popup.aspx"
                                ClientInstanceName="clientPopUpEmployee" Modal="True" HeaderText="DODAJ ZAPOSLENEGA"
                                Theme="MetropolisBlue" CloseAction="CloseButton" Width="600px" Height="305px" PopupHorizontalAlign="WindowCenter"
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
                                <div class="DeleteButtonElements">
                                    <span class="AddEditButtons">
                                        <dx:ASPxButton ID="btnDeleteEmployee" runat="server" Text="Izbriši" AutoPostBack="false"
                                            Height="25" Width="90" ClientInstanceName="clientBtnDelete">
                                            <ClientSideEvents Click="PlanPopUpShow" />
                                            <Image Url="../../../Images/trash2.png"></Image>
                                        </dx:ASPxButton>
                                    </span>
                                </div>
                                <div class="AddEditButtonsElements">
                                    <span class="AddEditButtons">
                                        <dx:ASPxButton ID="btnAddEmployee" runat="server" Text="Dodaj" AutoPostBack="false"
                                            Height="25" Width="90" ClientInstanceName="clientBtnAdd">
                                            <ClientSideEvents Click="PlanPopUpShow" />
                                            <Image Url="../../../Images/add2.png"></Image>
                                        </dx:ASPxButton>
                                    </span>
                                    <span class="AddEditButtons">
                                        <dx:ASPxButton ID="btnEditEmployee" runat="server" Text="Spremeni" AutoPostBack="false"
                                            Height="25" Width="90" ClientInstanceName="clientBtnEdit">
                                            <ClientSideEvents Click="PlanPopUpShow" />
                                            <Image Url="../../../Images/edit2.png"></Image>
                                        </dx:ASPxButton>
                                    </span>

                                </div>
                            </div>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
    <script type="text/javascript" src="../../../Scripts/ChromeFix_14.js"></script>
</asp:Content>
