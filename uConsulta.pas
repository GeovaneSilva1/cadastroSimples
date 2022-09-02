unit uConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DbClient, Menus;

type
  TfrmConsulta = class(TForm)
    pnConsulta: TPanel;
    rgPesquisar: TRadioGroup;
    edInserirPesquisa: TEdit;
    btPesquisar: TBitBtn;
    grConsulta: TDBGrid;
    btLimpar: TBitBtn;
    mnFiltros: TMainMenu;
    Filtros: TMenuItem;
    procedure btPesquisarClick(Sender: TObject);
    procedure rgPesquisarClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure FiltrosClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    wCdsConsulta: TClientDataset;

  end;

var
  frmConsulta: TfrmConsulta;

implementation

uses uTreinamento, uFiltro, DB, uProcedimentosPadroes;

{$R *.dfm}

procedure TfrmConsulta.btPesquisarClick(Sender: TObject);
var
  wCamposVazios : string;
begin
  wCamposVazios := '';
  if rgPesquisar.ItemIndex = 0 then   //fazendo o filtro do campo ID
     begin
       wCamposVazios := edInserirPesquisa.Text;
       if fExisteCamposVazios(wCamposVazios) then
          edInserirPesquisa.SetFocus
       else if fEntradaValoresEmCampos(edInserirPesquisa.Text, 1) then
          edInserirPesquisa.SetFocus
       else
          begin
            grConsulta.DataSource.DataSet.Filter := 'bdID ='+QuotedStr(edInserirPesquisa.Text);
            grConsulta.DataSource.DataSet.Filtered := True;
          end;
     end
  else if rgPesquisar.ItemIndex = 1 then //filtro IDADE
     begin
       wCamposVazios := edInserirPesquisa.Text;
       if fExisteCamposVazios(wCamposVazios) then
          edInserirPesquisa.SetFocus
       else if fEntradaValoresEmCampos(edInserirPesquisa.Text, 1) then
          edInserirPesquisa.SetFocus
       else
          begin
            grConsulta.DataSource.DataSet.Filter := 'bdIDADE ='+QuotedStr(edInserirPesquisa.Text);
            grConsulta.DataSource.DataSet.Filtered := True;
          end;
     end
  else if rgPesquisar.ItemIndex = 2 then //filtro Gênero
     begin
       wCamposVazios := edInserirPesquisa.text;
       if fExisteCamposVazios(wCamposVazios) then
          edInserirPesquisa.SetFocus
       else if fEntradaValoresEmCampos(edInserirPesquisa.Text, 0) then
          edInserirPesquisa.SetFocus
       else
          begin
            grConsulta.DataSource.DataSet.Filter := 'bdSEXO ='+QuotedStr(edInserirPesquisa.Text);
            grConsulta.DataSource.DataSet.Filtered := True;
          end;
     end
  else if rgPesquisar.ItemIndex = 3   then //filtro salario
     begin
       wCamposVazios := edInserirPesquisa.text;
       if fExisteCamposVazios(wCamposVazios)   then
          edInserirPesquisa.setFocus
       else if fEntradaValoresEmCampos(edInserirpesquisa.Text, 1)   then
          edInserirPesquisa.SetFocus
       else
          begin
            grConsulta.DataSOurce.DataSet.Filter   := 'bdSALARIO ='+QuotedStr(edInserirPesquisa.Text);
            grConsulta.DataSource.DataSet.Filtered := True;
          end;
     end
  else if rgPesquisar.ItemIndex = 4 then  //estado Civil
     begin
       wCamposVazios := edInserirPesquisa.Text;
       if fExisteCamposVazios(wCamposVazios) then
          edInserirPesquisa.setFocus
       else if fEntradaValoresEmCampos(edInserirPesquisa.Text, 0) then
          edInserirPesquisa.SetFocus
       else
          begin
            grCOnsulta.DataSource.DataSet.Filter   := 'bdESTADOCIVIL ='+QuotedStr(edInserirPesquisa.Text);
            grConsulta.DataSource.DataSet.Filtered := True;
            //grConsulta.DataSource.DataSet.Locate('bdESTADOCIVIL', edInserirPesquisa.Text,[loPartialKey, loCaseInsensitive]);
          end;
     end;
end;

procedure TfrmConsulta.rgPesquisarClick(Sender: TObject);
begin
  if rgPesquisar.ItemIndex = 0 then
     edInserirPesquisa.Clear
  else if rgPesquisar.ItemIndex = 1 then
     edInserirPesquisa.Clear
  else if rgPesquisar.ItemIndex = 2 then
     edInserirPesquisa.Clear
  else if rgPesquisar.ItemIndex = 3 then
     edInserirPesquisa.Clear
  else
     edInserirPesquisa.Clear;
end;

procedure TfrmConsulta.btLimparClick(Sender: TObject);
begin
  grConsulta.DataSource.DataSet.Filtered := False;
end;

procedure TfrmConsulta.FiltrosClick(Sender: TObject);
var
  wFiltro : TfrmFiltros;
begin
  wFiltro := TfrmFiltros.Create(Self);
  wFiltro.Show;
end;

procedure TfrmConsulta.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ftabEnter(Key) then
end;

end.
