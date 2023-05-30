///
//  Generated code. Do not modify.
//  source: google/ai/generativelanguage/v1beta2/discuss_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'safety.pb.dart' as $1;
import 'citation.pb.dart' as $2;

class GenerateMessageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GenerateMessageRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'model')
    ..aOM<MessagePrompt>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'prompt',
        subBuilder: MessagePrompt.create)
    ..a<$core.double>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'temperature',
        $pb.PbFieldType.OF)
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'candidateCount',
        $pb.PbFieldType.O3)
    ..a<$core.double>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'topP',
        $pb.PbFieldType.OF)
    ..a<$core.int>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'topK',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  GenerateMessageRequest._() : super();
  factory GenerateMessageRequest({
    $core.String? model,
    MessagePrompt? prompt,
    $core.double? temperature,
    $core.int? candidateCount,
    $core.double? topP,
    $core.int? topK,
  }) {
    final _result = create();
    if (model != null) {
      _result.model = model;
    }
    if (prompt != null) {
      _result.prompt = prompt;
    }
    if (temperature != null) {
      _result.temperature = temperature;
    }
    if (candidateCount != null) {
      _result.candidateCount = candidateCount;
    }
    if (topP != null) {
      _result.topP = topP;
    }
    if (topK != null) {
      _result.topK = topK;
    }
    return _result;
  }
  factory GenerateMessageRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GenerateMessageRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GenerateMessageRequest clone() =>
      GenerateMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GenerateMessageRequest copyWith(
          void Function(GenerateMessageRequest) updates) =>
      super.copyWith((message) => updates(message as GenerateMessageRequest))
          as GenerateMessageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateMessageRequest create() => GenerateMessageRequest._();
  GenerateMessageRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateMessageRequest> createRepeated() =>
      $pb.PbList<GenerateMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateMessageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateMessageRequest>(create);
  static GenerateMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get model => $_getSZ(0);
  @$pb.TagNumber(1)
  set model($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasModel() => $_has(0);
  @$pb.TagNumber(1)
  void clearModel() => clearField(1);

  @$pb.TagNumber(2)
  MessagePrompt get prompt => $_getN(1);
  @$pb.TagNumber(2)
  set prompt(MessagePrompt v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPrompt() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrompt() => clearField(2);
  @$pb.TagNumber(2)
  MessagePrompt ensurePrompt() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get temperature => $_getN(2);
  @$pb.TagNumber(3)
  set temperature($core.double v) {
    $_setFloat(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTemperature() => $_has(2);
  @$pb.TagNumber(3)
  void clearTemperature() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get candidateCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set candidateCount($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCandidateCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCandidateCount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get topP => $_getN(4);
  @$pb.TagNumber(5)
  set topP($core.double v) {
    $_setFloat(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTopP() => $_has(4);
  @$pb.TagNumber(5)
  void clearTopP() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get topK => $_getIZ(5);
  @$pb.TagNumber(6)
  set topK($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasTopK() => $_has(5);
  @$pb.TagNumber(6)
  void clearTopK() => clearField(6);
}

class GenerateMessageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GenerateMessageResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..pc<Message>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'candidates',
        $pb.PbFieldType.PM,
        subBuilder: Message.create)
    ..pc<Message>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'messages',
        $pb.PbFieldType.PM,
        subBuilder: Message.create)
    ..pc<$1.ContentFilter>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'filters',
        $pb.PbFieldType.PM,
        subBuilder: $1.ContentFilter.create)
    ..hasRequiredFields = false;

  GenerateMessageResponse._() : super();
  factory GenerateMessageResponse({
    $core.Iterable<Message>? candidates,
    $core.Iterable<Message>? messages,
    $core.Iterable<$1.ContentFilter>? filters,
  }) {
    final _result = create();
    if (candidates != null) {
      _result.candidates.addAll(candidates);
    }
    if (messages != null) {
      _result.messages.addAll(messages);
    }
    if (filters != null) {
      _result.filters.addAll(filters);
    }
    return _result;
  }
  factory GenerateMessageResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GenerateMessageResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GenerateMessageResponse clone() =>
      GenerateMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GenerateMessageResponse copyWith(
          void Function(GenerateMessageResponse) updates) =>
      super.copyWith((message) => updates(message as GenerateMessageResponse))
          as GenerateMessageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateMessageResponse create() => GenerateMessageResponse._();
  GenerateMessageResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateMessageResponse> createRepeated() =>
      $pb.PbList<GenerateMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateMessageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateMessageResponse>(create);
  static GenerateMessageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Message> get candidates => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Message> get messages => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$1.ContentFilter> get filters => $_getList(2);
}

class Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Message',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'author')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'content')
    ..aOM<$2.CitationMetadata>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'citationMetadata',
        subBuilder: $2.CitationMetadata.create)
    ..hasRequiredFields = false;

  Message._() : super();
  factory Message({
    $core.String? author,
    $core.String? content,
    $2.CitationMetadata? citationMetadata,
  }) {
    final _result = create();
    if (author != null) {
      _result.author = author;
    }
    if (content != null) {
      _result.content = content;
    }
    if (citationMetadata != null) {
      _result.citationMetadata = citationMetadata;
    }
    return _result;
  }
  factory Message.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Message copyWith(void Function(Message) updates) =>
      super.copyWith((message) => updates(message as Message))
          as Message; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get author => $_getSZ(0);
  @$pb.TagNumber(1)
  set author($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAuthor() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuthor() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  $2.CitationMetadata get citationMetadata => $_getN(2);
  @$pb.TagNumber(3)
  set citationMetadata($2.CitationMetadata v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCitationMetadata() => $_has(2);
  @$pb.TagNumber(3)
  void clearCitationMetadata() => clearField(3);
  @$pb.TagNumber(3)
  $2.CitationMetadata ensureCitationMetadata() => $_ensure(2);
}

class MessagePrompt extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'MessagePrompt',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'context')
    ..pc<Example>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'examples',
        $pb.PbFieldType.PM,
        subBuilder: Example.create)
    ..pc<Message>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'messages',
        $pb.PbFieldType.PM,
        subBuilder: Message.create)
    ..hasRequiredFields = false;

  MessagePrompt._() : super();
  factory MessagePrompt({
    $core.String? context,
    $core.Iterable<Example>? examples,
    $core.Iterable<Message>? messages,
  }) {
    final _result = create();
    if (context != null) {
      _result.context = context;
    }
    if (examples != null) {
      _result.examples.addAll(examples);
    }
    if (messages != null) {
      _result.messages.addAll(messages);
    }
    return _result;
  }
  factory MessagePrompt.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MessagePrompt.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MessagePrompt clone() => MessagePrompt()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MessagePrompt copyWith(void Function(MessagePrompt) updates) =>
      super.copyWith((message) => updates(message as MessagePrompt))
          as MessagePrompt; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MessagePrompt create() => MessagePrompt._();
  MessagePrompt createEmptyInstance() => create();
  static $pb.PbList<MessagePrompt> createRepeated() =>
      $pb.PbList<MessagePrompt>();
  @$core.pragma('dart2js:noInline')
  static MessagePrompt getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MessagePrompt>(create);
  static MessagePrompt? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get context => $_getSZ(0);
  @$pb.TagNumber(1)
  set context($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasContext() => $_has(0);
  @$pb.TagNumber(1)
  void clearContext() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Example> get examples => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<Message> get messages => $_getList(2);
}

class Example extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Example',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..aOM<Message>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'input',
        subBuilder: Message.create)
    ..aOM<Message>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'output',
        subBuilder: Message.create)
    ..hasRequiredFields = false;

  Example._() : super();
  factory Example({
    Message? input,
    Message? output,
  }) {
    final _result = create();
    if (input != null) {
      _result.input = input;
    }
    if (output != null) {
      _result.output = output;
    }
    return _result;
  }
  factory Example.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Example.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Example clone() => Example()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Example copyWith(void Function(Example) updates) =>
      super.copyWith((message) => updates(message as Example))
          as Example; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Example create() => Example._();
  Example createEmptyInstance() => create();
  static $pb.PbList<Example> createRepeated() => $pb.PbList<Example>();
  @$core.pragma('dart2js:noInline')
  static Example getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Example>(create);
  static Example? _defaultInstance;

  @$pb.TagNumber(1)
  Message get input => $_getN(0);
  @$pb.TagNumber(1)
  set input(Message v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasInput() => $_has(0);
  @$pb.TagNumber(1)
  void clearInput() => clearField(1);
  @$pb.TagNumber(1)
  Message ensureInput() => $_ensure(0);

  @$pb.TagNumber(2)
  Message get output => $_getN(1);
  @$pb.TagNumber(2)
  set output(Message v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOutput() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutput() => clearField(2);
  @$pb.TagNumber(2)
  Message ensureOutput() => $_ensure(1);
}

class CountMessageTokensRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CountMessageTokensRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'model')
    ..aOM<MessagePrompt>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'prompt',
        subBuilder: MessagePrompt.create)
    ..hasRequiredFields = false;

  CountMessageTokensRequest._() : super();
  factory CountMessageTokensRequest({
    $core.String? model,
    MessagePrompt? prompt,
  }) {
    final _result = create();
    if (model != null) {
      _result.model = model;
    }
    if (prompt != null) {
      _result.prompt = prompt;
    }
    return _result;
  }
  factory CountMessageTokensRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CountMessageTokensRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CountMessageTokensRequest clone() =>
      CountMessageTokensRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CountMessageTokensRequest copyWith(
          void Function(CountMessageTokensRequest) updates) =>
      super.copyWith((message) => updates(message as CountMessageTokensRequest))
          as CountMessageTokensRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CountMessageTokensRequest create() => CountMessageTokensRequest._();
  CountMessageTokensRequest createEmptyInstance() => create();
  static $pb.PbList<CountMessageTokensRequest> createRepeated() =>
      $pb.PbList<CountMessageTokensRequest>();
  @$core.pragma('dart2js:noInline')
  static CountMessageTokensRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CountMessageTokensRequest>(create);
  static CountMessageTokensRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get model => $_getSZ(0);
  @$pb.TagNumber(1)
  set model($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasModel() => $_has(0);
  @$pb.TagNumber(1)
  void clearModel() => clearField(1);

  @$pb.TagNumber(2)
  MessagePrompt get prompt => $_getN(1);
  @$pb.TagNumber(2)
  set prompt(MessagePrompt v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPrompt() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrompt() => clearField(2);
  @$pb.TagNumber(2)
  MessagePrompt ensurePrompt() => $_ensure(1);
}

class CountMessageTokensResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CountMessageTokensResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'tokenCount',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  CountMessageTokensResponse._() : super();
  factory CountMessageTokensResponse({
    $core.int? tokenCount,
  }) {
    final _result = create();
    if (tokenCount != null) {
      _result.tokenCount = tokenCount;
    }
    return _result;
  }
  factory CountMessageTokensResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CountMessageTokensResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CountMessageTokensResponse clone() =>
      CountMessageTokensResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CountMessageTokensResponse copyWith(
          void Function(CountMessageTokensResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CountMessageTokensResponse))
          as CountMessageTokensResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CountMessageTokensResponse create() => CountMessageTokensResponse._();
  CountMessageTokensResponse createEmptyInstance() => create();
  static $pb.PbList<CountMessageTokensResponse> createRepeated() =>
      $pb.PbList<CountMessageTokensResponse>();
  @$core.pragma('dart2js:noInline')
  static CountMessageTokensResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CountMessageTokensResponse>(create);
  static CountMessageTokensResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tokenCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set tokenCount($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTokenCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearTokenCount() => clearField(1);
}
