import java.util.HashMap;
import java.util.Map;

public class EvalVisitor extends ExprBaseVisitor<Integer> {

  @Override
  public Integer visitPrintExpr(ExprParser.PrintExprContext ctx) {
    int value = visit(ctx.expr());
    System.out.println(value);
    return 0;
  }

  @Override
  public Integer visitInt(ExprParser.IntContext ctx) {
    return Integer.valueOf(ctx.INT().getText());
  }

  @Override
  public Integer visitMulDiv(ExprParser.MulDivContext ctx) {
    int left = visit(ctx.expr(0));
    int right = visit(ctx.expr(1));
    if (ctx.op.getType() == ExprParser.MUL)
      return left * right;
    else
      return left / right;
  }

  @Override
  public Integer visitAddSub(ExprParser.AddSubContext ctx) {
    int left = visit(ctx.expr(0));
    int right = visit(ctx.expr(1));
    if (ctx.op.getType() == ExprParser.ADD)
      return left + right;
    else
      return left - right;
  }


  @Override
  public Integer visitParens(ExprParser.ParensContext ctx) {
    return visit(ctx.expr());
  }


  @Override
  public Integer visitAssign(ExprParser.AssignContext ctx) {
    // Get the text of your ID
    String id = ctx.ID().getText();
    // Get the value of the sub-expression
    int value = visit(ctx.expr());

    idMap.put(id, value);


    return value;
  }


  @Override
  public Integer visitId(ExprParser.IdContext ctx) {
    String stre = ctx.ID().getText();
    if (idMap.get(stre) == null)
        return 0;
    else
        return idMap.get(stre);
    
  }
}
