// Publisher
import List "mo:base/List";
import List "mo:base/List";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Time "mo:base/Time";
import Int "mo:base/Int";
import Char "mo:base/Char";
import AssocList "mo:base/AssocList";
import Buffer "mo:base/Buffer";
import Random "mo:base/Random";
import RBTree "mo:base/RBTree";
import HashMap "mo:base/HashMap";
import Array "mo:base/Array";

import FileTypes "./types/FileStorageTypes";
import Utils "./Utils";

import Types "./Types";
import HTTP "./Http";

import Stoic "./EXT/Stoic";

import Protocol "./Protocol";
import Testable "mo:matchers/Testable";
import Blob "mo:base/Blob";


actor Publisher {

  type Prompt = {
    topic : Text;
    getchat(chatID: Text)
  };

  type Subscriber = {
    topic : Text;
    callback : shared Prompt -> ();
  };

  stable var subscribers = List.nil<Subscriber>();

  public func subscribe(subscriber : Subscriber) {
    subscribers := List.push(subscriber, subscribers);
  };

  public func publish(prompt : Prompt) {
    for (subscriber in List.toArray(subscribers).vals()) {
      if (subscriber.topic == prompt.topic) {
        subscriber.callback(prompt);
      };
    };
  };
}