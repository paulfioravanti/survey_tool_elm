module UpdateTest exposing (updateTests)

import Expect
import Factory.Config as Config
import Factory.Navigation.Location as Location
import Model exposing (Model)
import Msg exposing (Msg(UpdatePage))
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            , SurveyResultDetailRoute
            )
        )
import Test exposing (Test, describe, test)
import Update


updateTests : Test
updateTests =
    let
        msg =
            UpdatePage ()
    in
        describe "update when UpdatePage msg sent"
            [ test
                """
                when the route is ListSurveyResultsRoute, it updates the
                surveyResultsList to Requesting when it is NotRequested.
                """
              <|
                \() ->
                    let
                        model =
                            Model
                                NotRequested
                                Config.factory
                                ListSurveyResultsRoute
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model | surveyResultList = Requesting }
            , test
                """
                when the route is ListSurveyResultsRoute, it does not update the
                model if surveyResultsList has already been requested
                (ie it is not NotRequested).
                """
              <|
                \() ->
                    let
                        model =
                            Model
                                Requesting
                                Config.factory
                                ListSurveyResultsRoute
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal model
            , test
                """
                when the route is SurveyResultDetailRoute, it does not update
                the model.
                """
              <|
                \() ->
                    let
                        model =
                            Model
                                Requesting
                                Config.factory
                                (SurveyResultDetailRoute "10")
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal model
            , test
                """
                when the route is none of the above routes, it does not update
                the model.
                """
              <|
                \() ->
                    let
                        model =
                            Model
                                Requesting
                                Config.factory
                                NotFoundRoute
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal model
            ]
