port module Main exposing (main)

import Platform
import String

port output : String -> Cmd msg
port error : String -> Cmd msg

type alias Flags =
    List String

type alias Model =
    ()

type Msg
    = Noop

type alias Family =
    { id : String
    , renderer : String
    , tranche : String
    , contextKey : String
    , contextValue : String
    }

families : List Family
families =
    [ Family "code_analyzer" "classic-six.code_analyzer" "classic-six" "analysisFocus" "elm-worker-audit"
    , Family "data_processing" "classic-six.data_processing" "classic-six" "dataWindow" "list-stream-reconciliation"
    , Family "jargon" "classic-six.jargon" "classic-six" "languagePolicy" "elm-glossary"
    , Family "metrics" "classic-six.metrics" "classic-six" "signalBlend" "runtime-port-latency"
    , Family "network_activity" "classic-six.network_activity" "classic-six" "transportMix" "socket-http-sse"
    , Family "system_monitoring" "classic-six.system_monitoring" "classic-six" "telemetryScope" "elm-worker-runtime-host"
    , Family "agent_workflows" "modern-core.agent_workflows" "modern-core" "coordinationMode" "port-dispatch-handshake"
    , Family "platform_engineering" "modern-core.platform_engineering" "modern-core" "platformSurface" "elm-node-validation-lane"
    , Family "observability_ai_runtime" "modern-core.observability_ai_runtime" "modern-core" "runtimeSignals" "logs-metrics-provider-boundary"
    , Family "delivery_preview_ops" "modern-core.delivery_preview_ops" "modern-core" "deliveryGuardrail" "compiled-preview-checkpoints"
    , Family "supply_chain_security" "modern-core.supply_chain_security" "modern-core" "supplyChainPosture" "source-js-attestation"
    ]
        ++ fallback "fallback.ai_governance" "fallback-ai_governance" "ai_governance" [ "ai_inference_ops", "evaluation_and_guardrails", "knowledge_retrieval", "edge_client_runtime", "identity_and_trust", "aibom_provenance", "agent_boundary_security", "embedded_agentic_pipeline", "data_governance_compliance", "finops_capacity" ]
        ++ fallback "fallback.security_blockchain" "fallback-security_blockchain" "security_blockchain" [ "blockchain_protocol_ops", "cross_chain_interop", "proof_and_sequencer_ops" ]
        ++ fallback "fallback.overlay_quantum" "fallback-overlay_quantum" "overlay_quantum" [ "hybrid_runtime_ops", "capacity_cost_controller", "batch_execution_tuner", "compiler_maintainer", "interop_adapter_engineer", "preflight_capacity_planner", "simulator_performance_engineer" ]
        ++ fallback "fallback.health_protocol" "fallback-health_protocol" "health_protocol" [ "fhir_profile_generator", "smart_launch_oauth", "bulk_fhir_population_ops", "hl7v2_feed_ops", "clinical_workflow_events", "dicomweb_imaging_ops", "openehr_semantic_record_ops", "device_telemetry_clinical", "emr_vendor_adapter", "ocpp_chargepoint_ops", "ocpi_roaming_ops", "mcp_a2a_ops", "streaming_bus_ops", "service_mesh_rpc_ops" ]

fallback : String -> String -> String -> List String -> List Family
fallback renderer tranche value ids =
    List.map (\id -> Family id renderer tranche "fallbackFamily" value) ids

registryId : String -> String
registryId value =
    String.replace "_" "-" value

normalizeFamily : String -> String
normalizeFamily value =
    value |> String.toLower |> String.replace "-" "_"

findFamily : String -> Maybe Family
findFamily value =
    let
        normalized = normalizeFamily value
    in
    List.filter (\family -> family.id == normalized) families |> List.head

hashText : String -> Int
hashText value =
    value
        |> String.toList
        |> List.foldl (\ch acc -> modBy 900000 (acc * 33 + Char.toCode ch)) 5381

pad2 : Int -> String
pad2 value =
    if value < 10 then
        "0" ++ String.fromInt value
    else
        String.fromInt value

quotedIds : List Family -> String
quotedIds rows =
    rows |> List.map (\family -> "\"" ++ registryId family.id ++ "\"") |> String.join ","

registry : String
registry =
    let
        rows =
            families
                |> List.map (\family -> "{\"id\":\"" ++ family.id ++ "\",\"registryId\":\"" ++ registryId family.id ++ "\",\"rendererKey\":\"" ++ family.renderer ++ "\",\"tranche\":\"" ++ family.tranche ++ "\"}")
                |> String.join ","

        classic =
            List.filter (\family -> family.tranche == "classic-six") families

        modern =
            List.filter (\family -> family.tranche == "modern-core") families

        later =
            List.filter (\family -> family.tranche /= "classic-six" && family.tranche /= "modern-core") families
    in
    "{\"outputFormats\":[\"text\",\"json\"],\"flags\":[\"list-values\",\"focus-family\",\"output-format\",\"seed\",\"experimental-provider\"],\"generatorFamilies\":[" ++ rows ++ "],\"classicSix\":[" ++ quotedIds classic ++ "],\"modernCore\":[" ++ quotedIds modern ++ "],\"fallbackFamilies\":[" ++ quotedIds later ++ "],\"implementationMode\":\"family-focus-deterministic\"}"

payload : Family -> String -> String -> String
payload family seed outputFormat =
    let
        hash =
            hashText (seed ++ "::" ++ family.id)

        seconds =
            modBy 86400 hash

        hour =
            seconds // 3600

        minute =
            modBy 3600 seconds // 60

        second =
            modBy 60 seconds

        sequence =
            1000 + modBy 9000 hash

        timestamp =
            "2026-01-01T" ++ pad2 hour ++ ":" ++ pad2 minute ++ ":" ++ pad2 second ++ "Z"

        fingerprint =
            registryId family.id ++ "-" ++ String.fromInt hash
    in
    if outputFormat == "json" then
        "{\"eventType\":\"stakeholder.generator.output\",\"sequence\":" ++ String.fromInt sequence ++ ",\"family\":\"" ++ family.id ++ "\",\"message\":\"Deterministic elm tranche for " ++ family.id ++ "\",\"timestamp\":\"" ++ timestamp ++ "\",\"context\":{\"rendererKey\":\"" ++ family.renderer ++ "\",\"" ++ family.contextKey ++ "\":\"" ++ family.contextValue ++ "\",\"seedFingerprint\":\"" ++ fingerprint ++ "\",\"tranche\":\"" ++ family.tranche ++ "\",\"elmProfile\":\"platform-worker-port-catalog\"},\"generationProvenance\":{\"sourceRepo\":\"elm-stakeholder\",\"baseline\":\"local-small-tranche-family-focus\",\"experimental\":false,\"adapterType\":\"static-record-catalog\",\"promptVersion\":null},\"outputFormat\":\"json\"}"
    else
        "family: " ++ family.id ++ "\nrenderer: " ++ family.renderer ++ "\ntranche: " ++ family.tranche ++ "\nsequence: " ++ String.fromInt sequence ++ "\ntimestamp: " ++ timestamp ++ "\nmessage: Deterministic elm tranche for " ++ family.id

type alias State =
    { focusFamily : String
    , seed : String
    , outputFormat : String
    , listValues : Bool
    , failure : Maybe String
    }

parse : List String -> State -> State
parse args state =
    case args of
        [] ->
            state

        "--list-values" :: rest ->
            parse rest { state | listValues = True }

        "--focus-family" :: value :: rest ->
            parse rest { state | focusFamily = value }

        "--focus-family" :: [] ->
            { state | failure = Just "missing value for --focus-family" }

        "--seed" :: value :: rest ->
            parse rest { state | seed = value }

        "--seed" :: [] ->
            { state | failure = Just "missing value for --seed" }

        "--output-format" :: value :: rest ->
            if value == "text" || value == "json" then
                parse rest { state | outputFormat = value }
            else
                { state | failure = Just ("invalid --output-format: " ++ value) }

        "--output-format" :: [] ->
            { state | failure = Just "missing value for --output-format" }

        "--experimental-provider" :: value :: _ ->
            { state | failure = Just ("experimental provider is not enabled in the deterministic first tranche: " ++ value) }

        "--experimental-provider" :: [] ->
            { state | failure = Just "missing value for --experimental-provider" }

        arg :: _ ->
            if String.startsWith "--experimental-" arg then
                { state | failure = Just "experimental flags require --experimental-provider" }
            else
                { state | failure = Just ("unknown argument: " ++ arg) }

run : Flags -> Cmd Msg
run flags =
    let
        state =
            parse flags { focusFamily = "", seed = "default-seed", outputFormat = "text", listValues = False, failure = Nothing }
    in
    case state.failure of
        Just message ->
            error message

        Nothing ->
            if state.listValues then
                output registry
            else if state.focusFamily == "" then
                error "focus-family is required and must be a known generator family"
            else
                case findFamily state.focusFamily of
                    Just family ->
                        output (payload family state.seed state.outputFormat)

                    Nothing ->
                        error ("invalid --focus-family: " ++ state.focusFamily)

init : Flags -> ( Model, Cmd Msg )
init flags =
    ( (), run flags )

update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

main : Program Flags Model Msg
main =
    Platform.worker { init = init, update = update, subscriptions = subscriptions }
