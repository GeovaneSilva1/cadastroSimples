unit uFiltro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTreinamento, ExtCtrls, uConsulta, DB, Buttons, DbClient;

type
  TfrmFiltros = class(TForm)
    pnFiltro: TPanel;
    edIgualA: TEdit;
    edMenorQ: TEdit;
    edMaiorQ: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btFiltro: TBitBtn;
    btLimpaFiltro: TBitBtn;
    Label6: TLabel;
    edIdadeIgual: TEdit;
    Label7: TLabel;
    edIdadeAte: TEdit;
    Label8: TLabel;
    edIdadeMaiorQ: TEdit;
    rgConsulGenero: TRadioGroup;
    cbConsulEC: TComboBox;
    gbSalario: TGroupBox;
    gbIdade: TGroupBox;
    gbEstadoCivil: TGroupBox;
    procedure btFiltroClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btLimpaFiltroClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    wCdsFiltro: TClientDataSet;
    wFiltro: TfrmConsulta;
    wfrmPrincipal : TfrmPrincipal;
  end;

var
  frmFiltros: TfrmFiltros;

implementation

uses uProcedimentosPadroes;


{$R *.dfm}

procedure TfrmFiltros.btFiltroClick(Sender: TObject);
var
  wFiltroConsulta: String;
begin
  wFiltroConsulta:= '';

  //inicio filtro Salario
  if (edIgualA.Text <> '') and (edMenorQ.Text = '') and (edMaiorQ.Text = '') then  //igual a
     wFiltroConsulta     := 'bdSALARIO =' + QuotedStr(edIgualA.Text) +  'AND '
  else if (edMenorQ.Text <> '') and (edIgualA.Text = '') and (edMaiorQ.Text = '') then // só menor que
     wFiltroConsulta   := 'bdSALARIO <=' + QuotedStr(edMenorQ.Text) + 'AND '
  else
     begin
       if (edMaiorQ.Text <> '') and (edIgualA.Text = '') and (edMenorQ.Text = '') then  // só maior que
          wFiltroConsulta   := 'bdSALARIO >=' + QuotedStr(edMaiorQ.Text) + 'AND '
       else if (edMenorQ.Text <> '') and (edMaiorQ.Text <> '') then //valores entre o menor e o maior valor
          wFiltroConsulta := 'bdSALARIO >= ' + QuotedStr(edMenorQ.Text) + ' AND bdSALARIO <= ' + QuotedStr(edMaiorQ.Text) + 'AND ';
     end;

  //inicio filtro idade
  if (edIdadeIgual.Text <> '') and (edIdadeAte.Text = '') and (edIdadeMaiorQ.Text = '') then //só idade igual a
     wFiltroConsulta := wFiltroConsulta + 'bdIDADE =' + QuotedStr(edIdadeIgual.Text) +   'AND '
  else
     begin
       if (edIdadeAte.Text <> '') and (edIdadeIgual.Text = '') and (edIdadeMaiorQ.Text = '')   then //só idade até x
          wFiltroConsulta     := wFiltroConsulta + 'bdIDADE <=' + QuotedStr(edIdadeAte.Text) +    'AND '
       else if (edIdadeMaiorQ.Text <> '') and (edIdadeIgual.Text = '') and (edIdadeAte.Text = '')      then
          wFiltroConsulta   := wFiltroConsulta + 'bdIDADE >=' + QuotedStr(edIdadeMaiorQ.Text) + 'AND '
       else if (edIdadeAte.Text <> '')  and (edIdadeMaiorQ.Text <> '')                               then
          wFiltroConsulta := wFiltroConsulta + 'bdIDADE >=' + QuotedStr(edIdadeAte.Text) +    'AND bdIDADE <=' + QuotedStr(edIdadeMaiorQ.Text) + 'AND ';
     end;

  //inicio filtro Gênero
  if not (rgConsulGenero.ItemIndex = 0) then
     begin
       if rgConsulGenero.ItemIndex = 1 then
          wFiltroConsulta    := wFiltroConsulta + 'bdSEXO =' + QuotedStr('MASCULINO') + 'AND '
       else if rgConsulGenero.ItemIndex = 2 then
          wFiltroConsulta  := wFiltroConsulta + 'bdSEXO =' + QuotedStr('FEMININO')  + 'AND ';
     end;

  //Inicio filtro Estado Civil
  if not (cbConsulEC.Text = 'NENHUM') then
     wFiltroConsulta := wFiltroConsulta + 'bdESTADOCIVIL = '+ QuotedStr(cbConsulEC.Text) + 'AND ';

  //retirando o AND do final de todo o filtro.
  wFiltroConsulta      := Copy(wFiltroConsulta, 1, Length(wFiltroConsulta) - 4);

  //inserindo os filtros para a propriedade filter
  if wFiltroConsulta <> '' then
     begin
       wFiltro.grConsulta.DataSource.DataSet.Filter   := wFiltroConsulta;
       wFiltro.grConsulta.DataSource.DataSet.Filtered := True;
     end;
  //FIM

end;

procedure TfrmFiltros.FormCreate(Sender: TObject);
begin
  wFiltro       := TfrmConsulta.Create(Self);
  wfrmPrincipal := TfrmPrincipal.Create(Self);
end;

procedure TfrmFiltros.btLimpaFiltroClick(Sender: TObject);
begin
  wFiltro.grConsulta.DataSource.DataSet.Filtered := False;
  edIgualA.Clear;
  edMenorQ.Clear;
  edMaiorQ.Clear;
end;

procedure TfrmFiltros.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ftabEnter(Key) then
end;

end.
