package uk.gov.bis.taxserviceMock.controllers.gateway

import javax.inject.Inject

import play.api.Logger
import play.api.mvc.{Action, Controller}
import uk.gov.bis.taxserviceMock.actions.gateway.GatewayUserAction

class GrantScopeController @Inject()(UserAction: GatewayUserAction) extends Controller {

  def show(authId: String) = Action { implicit request =>
    Ok(views.html.gateway.grantscope(authId))
  }

  def grantScope(authId: String) = Action { implicit request =>
    val r = for {
      userId <- request.session.get(UserAction.validatedUserKey)
      uri <- request.session.get(UserAction.continueKey)
      _ = Logger.debug(s"redirect to $uri")
    } yield Redirect(uri)
      .removingFromSession(UserAction.continueKey)
      .removingFromSession(UserAction.validatedUserKey)
      .addingToSession((UserAction.sessionKey, userId))

    r.getOrElse(Unauthorized)
  }
}