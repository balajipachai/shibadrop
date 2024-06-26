// THIS IS AN AUTOGENERATED FILE. DO NOT EDIT THIS FILE DIRECTLY.

import {
  ethereum,
  JSONValue,
  TypedMap,
  Entity,
  Bytes,
  Address,
  BigInt,
} from "@graphprotocol/graph-ts";

export class NewInstance1155 extends ethereum.Event {
  get params(): NewInstance1155__Params {
    return new NewInstance1155__Params(this);
  }
}

export class NewInstance1155__Params {
  _event: NewInstance1155;

  constructor(event: NewInstance1155) {
    this._event = event;
  }

  get instance(): Address {
    return this._event.parameters[0].value.toAddress();
  }

  get creator(): Address {
    return this._event.parameters[1].value.toAddress();
  }
}

export class ERC1155ShibaDropCloneFactory extends ethereum.SmartContract {
  static bind(address: Address): ERC1155ShibaDropCloneFactory {
    return new ERC1155ShibaDropCloneFactory(
      "ERC1155ShibaDropCloneFactory",
      address,
    );
  }

  cloneableImplementation(): Address {
    let result = super.call(
      "cloneableImplementation",
      "cloneableImplementation():(address)",
      [],
    );

    return result[0].toAddress();
  }

  try_cloneableImplementation(): ethereum.CallResult<Address> {
    let result = super.tryCall(
      "cloneableImplementation",
      "cloneableImplementation():(address)",
      [],
    );
    if (result.reverted) {
      return new ethereum.CallResult();
    }
    let value = result.value;
    return ethereum.CallResult.fromValue(value[0].toAddress());
  }

  configurer(): Address {
    let result = super.call("configurer", "configurer():(address)", []);

    return result[0].toAddress();
  }

  try_configurer(): ethereum.CallResult<Address> {
    let result = super.tryCall("configurer", "configurer():(address)", []);
    if (result.reverted) {
      return new ethereum.CallResult();
    }
    let value = result.value;
    return ethereum.CallResult.fromValue(value[0].toAddress());
  }

  createClone(name: string, symbol: string, salt: Bytes): Address {
    let result = super.call(
      "createClone",
      "createClone(string,string,bytes32):(address)",
      [
        ethereum.Value.fromString(name),
        ethereum.Value.fromString(symbol),
        ethereum.Value.fromFixedBytes(salt),
      ],
    );

    return result[0].toAddress();
  }

  try_createClone(
    name: string,
    symbol: string,
    salt: Bytes,
  ): ethereum.CallResult<Address> {
    let result = super.tryCall(
      "createClone",
      "createClone(string,string,bytes32):(address)",
      [
        ethereum.Value.fromString(name),
        ethereum.Value.fromString(symbol),
        ethereum.Value.fromFixedBytes(salt),
      ],
    );
    if (result.reverted) {
      return new ethereum.CallResult();
    }
    let value = result.value;
    return ethereum.CallResult.fromValue(value[0].toAddress());
  }

  shibaport(): Address {
    let result = super.call("shibaport", "shibaport():(address)", []);

    return result[0].toAddress();
  }

  try_shibaport(): ethereum.CallResult<Address> {
    let result = super.tryCall("shibaport", "shibaport():(address)", []);
    if (result.reverted) {
      return new ethereum.CallResult();
    }
    let value = result.value;
    return ethereum.CallResult.fromValue(value[0].toAddress());
  }
}

export class ConstructorCall extends ethereum.Call {
  get inputs(): ConstructorCall__Inputs {
    return new ConstructorCall__Inputs(this);
  }

  get outputs(): ConstructorCall__Outputs {
    return new ConstructorCall__Outputs(this);
  }
}

export class ConstructorCall__Inputs {
  _call: ConstructorCall;

  constructor(call: ConstructorCall) {
    this._call = call;
  }

  get allowedShibaport(): Address {
    return this._call.inputValues[0].value.toAddress();
  }
}

export class ConstructorCall__Outputs {
  _call: ConstructorCall;

  constructor(call: ConstructorCall) {
    this._call = call;
  }
}

export class CreateCloneCall extends ethereum.Call {
  get inputs(): CreateCloneCall__Inputs {
    return new CreateCloneCall__Inputs(this);
  }

  get outputs(): CreateCloneCall__Outputs {
    return new CreateCloneCall__Outputs(this);
  }
}

export class CreateCloneCall__Inputs {
  _call: CreateCloneCall;

  constructor(call: CreateCloneCall) {
    this._call = call;
  }

  get name(): string {
    return this._call.inputValues[0].value.toString();
  }

  get symbol(): string {
    return this._call.inputValues[1].value.toString();
  }

  get salt(): Bytes {
    return this._call.inputValues[2].value.toBytes();
  }
}

export class CreateCloneCall__Outputs {
  _call: CreateCloneCall;

  constructor(call: CreateCloneCall) {
    this._call = call;
  }

  get instance(): Address {
    return this._call.outputValues[0].value.toAddress();
  }
}
