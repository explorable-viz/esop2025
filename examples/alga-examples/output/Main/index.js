import * as Algebra_Graph from "../Algebra.Graph/index.js";
import * as Algebra_Graph_AdjacencyMap from "../Algebra.Graph.AdjacencyMap/index.js";
import * as Algebra_Graph_Internal from "../Algebra.Graph.Internal/index.js";
import * as Control_Monad_State_Class from "../Control.Monad.State.Class/index.js";
import * as Control_Monad_State_Trans from "../Control.Monad.State.Trans/index.js";
import * as Data_Identity from "../Data.Identity/index.js";
import * as Data_List_Types from "../Data.List.Types/index.js";
import * as Data_Ord from "../Data.Ord/index.js";
import * as Data_Tuple from "../Data.Tuple/index.js";
import * as Data_Unfoldable from "../Data.Unfoldable/index.js";
import * as Effect from "../Effect/index.js";
import * as Effect_Console from "../Effect.Console/index.js";
import * as Effect_Random from "../Effect.Random/index.js";
import * as Node_ReadLine from "../Node.ReadLine/index.js";
var clique = /* #__PURE__ */ Algebra_Graph_AdjacencyMap.clique(Data_Ord.ordInt);
var replicateA = /* #__PURE__ */ Data_Unfoldable.replicateA(Effect.applicativeEffect)(Data_List_Types.unfoldableList)(Data_List_Types.traversableList);
var state = /* #__PURE__ */ Control_Monad_State_Class.state(/* #__PURE__ */ Control_Monad_State_Trans.monadStateStateT(Data_Identity.monadIdentity));
var main = function __do() {
    var inputInterface = Node_ReadLine.createConsoleInterface(Node_ReadLine.noCompletion)();
    Node_ReadLine.setPrompt("> ")(inputInterface)();
    Node_ReadLine.prompt(inputInterface)();
    return Node_ReadLine.setLineHandler(function (s) {
        var $15 = s === "quit";
        if ($15) {
            return Node_ReadLine.close(inputInterface);
        };
        var list = Algebra_Graph_Internal.fromArray([ 1, 2, 3, 4, 5 ]);
        var initGraph = clique(list);
        return function __do() {
            Effect_Console.log(s)();
            return Effect_Console.log("logged and loaded")();
        };
    })(inputInterface)();
};
var compareLists = function (v) {
    return function (v1) {
        if (v instanceof Data_List_Types.Cons && v1 instanceof Data_List_Types.Cons) {
            return new Data_List_Types.Cons(v.value0 >= v1.value0, compareLists(v.value1)(v1.value1));
        };
        if (v1 instanceof Data_List_Types.Cons) {
            return Data_List_Types.Nil.value;
        };
        return Data_List_Types.Nil.value;
    };
};
var boolList = function (numNodes) {
    return function (maxNum) {
        return function (edgeCounts) {
            return function __do() {
                var v = replicateA(numNodes)(Effect_Random.randomInt(1)(maxNum))();
                return compareLists(v)(edgeCounts);
            };
        };
    };
};
var addNode = function (n) {
    return state(function (g) {
        var newV = new Algebra_Graph.Vertex(n);
        return new Data_Tuple.Tuple(newV, Algebra_Graph.overlay(g)(newV));
    });
};

// Add edge within state
var addEdge = function (s) {
    return function (t) {
        return state(function (g) {
            var e = Algebra_Graph.edge(s)(t);
            return new Data_Tuple.Tuple(e, Algebra_Graph.overlay(g)(e));
        });
    };
};
export {
    addEdge,
    addNode,
    compareLists,
    boolList,
    main
};
