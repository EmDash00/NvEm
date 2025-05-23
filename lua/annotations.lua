--- @class vim.lsp.ClientSetupConfig
--- command string[] that launches the language
--- server (treated as in |jobstart()|, must be absolute or on `$PATH`, shell constructs like
--- "~" are not expanded), or function that creates an RPC client. Function receives
--- a `dispatchers` table and returns a table with member functions `request`, `notify`,
--- `is_closing` and `terminate`.
--- See |vim.lsp.rpc.request()|, |vim.lsp.rpc.notify()|.
---  For TCP there is a builtin RPC client factory: |vim.lsp.rpc.connect()|
--- @field cmd? string[]|fun(dispatchers: vim.lsp.rpc.Dispatchers): vim.lsp.rpc.PublicClient
---
--- Directory to launch the `cmd` process. Not related to `root_dir`.
--- (default: cwd)
--- @field cmd_cwd? string
---
--- Environment flags to pass to the LSP on spawn.
--- Must be specified using a table.
--- Non-string values are coerced to string.
--- Example:
--- ```lua
--- { PORT = 8080; HOST = "0.0.0.0"; }
--- ```
--- @field cmd_env? table
---
--- Daemonize the server process so that it runs in a separate process group from Nvim.
--- Nvim will shutdown the process on exit, but if Nvim fails to exit cleanly this could leave
--- behind orphaned server processes.
--- (default: true)
--- @field detached? boolean
---
--- List of workspace folders passed to the language server.
--- For backwards compatibility rootUri and rootPath will be derived from the first workspace
--- folder in this list. See `workspaceFolders` in the LSP spec.
--- @field workspace_folders? lsp.WorkspaceFolder[]
---
--- Map overriding the default capabilities defined by |vim.lsp.protocol.make_client_capabilities()|,
--- passed to the language server on initialization. Hint: use make_client_capabilities() and modify
--- its result.
--- - Note: To send an empty dictionary use |vim.empty_dict()|, else it will be encoded as an
---   array.
--- @field capabilities? lsp.ClientCapabilities
---
--- Map of language server method names to |lsp-handler|
--- @field handlers? table<string,function>
---
--- Map with language server specific settings.
--- See the {settings} in |vim.lsp.Client|.
--- @field settings? table
---
--- Table that maps string of clientside commands to user-defined functions.
--- Commands passed to start_client take precedence over the global command registry. Each key
--- must be a unique command name, and the value is a function which is called if any LSP action
--- (code action, code lenses, ...) triggers the command.
--- @field commands? table<string,fun(command: lsp.Command, ctx: table)>
---
--- Values to pass in the initialization request as `initializationOptions`. See `initialize` in
--- the LSP spec.
--- @field init_options? table
---
--- Name in log messages.
--- (default: client-id)
--- @field name? string
---
--- Language ID as string. Defaults to the filetype.
--- @field get_language_id? fun(bufnr: integer, filetype: string): string
---
--- The encoding that the LSP server expects. Client does not verify this is correct.
--- @field offset_encoding? 'utf-8'|'utf-16'|'utf-32'
---
--- Callback invoked when the client operation throws an error. `code` is a number describing the error.
--- Other arguments may be passed depending on the error kind.  See `vim.lsp.rpc.client_errors`
--- for possible errors. Use `vim.lsp.rpc.client_errors[code]` to get human-friendly name.
--- @field on_error? fun(code: integer, err: string)
---
--- Callback invoked before the LSP "initialize" phase, where `params` contains the parameters
--- being sent to the server and `config` is the config that was passed to |vim.lsp.start_client()|.
--- You can use this to modify parameters before they are sent.
--- @field before_init? fun(params: lsp.InitializeParams, config: vim.lsp.ClientConfig)
---
--- Callback invoked after LSP "initialize", where `result` is a table of `capabilities`
--- and anything else the server may send. For example, clangd sends
--- `initialize_result.offsetEncoding` if `capabilities.offsetEncoding` was sent to it.
--- You can only modify the `client.offset_encoding` here before any notifications are sent.
--- @field on_init? elem_or_list<fun(client: vim.lsp.Client, initialize_result: lsp.InitializeResult)>
---
--- Callback invoked on client exit.
---   - code: exit code of the process
---   - signal: number describing the signal used to terminate (if any)
---   - client_id: client handle
--- @field on_exit? elem_or_list<fun(code: integer, signal: integer, client_id: integer)>
---
--- Callback invoked when client attaches to a buffer.
--- @field on_attach? elem_or_list<fun(client: vim.lsp.Client, bufnr: integer)>
---
--- Passed directly to the language server in the initialize request. Invalid/empty values will
--- (default: "off")
--- @field trace? 'off'|'messages'|'verbose'
---
--- A table with flags for the client. The current (experimental) flags are:
--- @field flags? vim.lsp.Client.Flags
---
--- Directory where the LSP server will base its workspaceFolders, rootUri, and rootPath on initialization.
--- @field root_dir? string

--- @class vim.lsp.Client.Progress: vim.Ringbuf<{token: integer|string, value: any}>
--- @field pending table<lsp.ProgressToken,lsp.LSPAny>

--- @class vim.lsp.Client
---
--- The id allocated to the client.
--- @field id integer
---
--- If a name is specified on creation, that will be used. Otherwise it is just
--- the client id. This is used for logs and messages.
--- @field name string
---
--- RPC client object, for low level interaction with the client.
--- See |vim.lsp.rpc.start()|.
--- @field rpc vim.lsp.rpc.PublicClient
---
--- The encoding used for communicating with the server. You can modify this in
--- the `config`'s `on_init` method before text is sent to the server.
--- @field offset_encoding string
---
--- The handlers used by the client as described in |lsp-handler|.
--- @field handlers table<string,lsp.Handler>
---
--- The current pending requests in flight to the server. Entries are key-value
--- pairs with the key being the request id while the value is a table with
--- `type`, `bufnr`, and `method` key-value pairs. `type` is either "pending"
--- for an active request, or "cancel" for a cancel request. It will be
--- "complete" ephemerally while executing |LspRequest| autocmds when replies
--- are received from the server.
--- @field requests table<integer,{ type: string, bufnr: integer, method: string}>
---
--- copy of the table that was passed by the user
--- to |vim.lsp.start_client()|.
--- @field config vim.lsp.ClientConfig
---
--- Response from the server sent on `initialize` describing the server's
--- capabilities.
--- @field server_capabilities lsp.ServerCapabilities?
---
--- A ring buffer (|vim.ringbuf()|) containing progress messages
--- sent by the server.
--- @field progress vim.lsp.Client.Progress
---
--- @field initialized true?
---
--- The workspace folders configured in the client when the server starts.
--- This property is only available if the client supports workspace folders.
--- It can be `null` if the client supports workspace folders but none are
--- configured.
--- @field workspace_folders lsp.WorkspaceFolder[]?
--- @field root_dir string?
---
--- @field attached_buffers table<integer,true>
---
--- Buffers that should be attached to upon initialize()
--- @field package _buffers_to_attach table<integer,true>
---
--- @field private _log_prefix string
---
--- Track this so that we can escalate automatically if we've already tried a
--- graceful shutdown
--- @field private _graceful_shutdown_failed true?
---
--- The initial trace setting. If omitted trace is disabled ("off").
--- trace = "off" | "messages" | "verbose";
--- @field private _trace 'off'|'messages'|'verbose'
---
--- Table of command name to function which is called if any LSP action
--- (code action, code lenses, ...) triggers the command.
--- Client commands take precedence over the global command registry.
--- @field commands table<string,fun(command: lsp.Command, ctx: table)>
---
--- Map with language server specific settings. These are returned to the
--- language server if requested via `workspace/configuration`. Keys are
--- case-sensitive.
--- @field settings table
---
--- A table with flags for the client. The current (experimental) flags are:
--- @field flags vim.lsp.Client.Flags
---
--- @field get_language_id fun(bufnr: integer, filetype: string): string
---
--- The capabilities provided by the client (editor or tool)
--- @field capabilities lsp.ClientCapabilities
--- @field dynamic_capabilities lsp.DynamicCapabilities
---
--- Sends a request to the server.
--- This is a thin wrapper around {client.rpc.request} with some additional
--- checking.
--- If {handler} is not specified and if there's no respective global
--- handler, then an error will occur.
--- Returns: {status}, {client_id}?. {status} is a boolean indicating if
--- the notification was successful. If it is `false`, then it will always
--- be `false` (the client has shutdown).
--- If {status} is `true`, the function returns {request_id} as the second
--- result. You can use this with `client.cancel_request(request_id)` to cancel
--- the request.
--- @field request fun(method: string, params: table?, handler: lsp.Handler?, bufnr: integer?): boolean, integer?
---
--- Sends a request to the server and synchronously waits for the response.
--- This is a wrapper around {client.request}
--- Returns: { err=err, result=result }, a dictionary, where `err` and `result`
--- come from the |lsp-handler|. On timeout, cancel or error, returns `(nil,
--- err)` where `err` is a string describing the failure reason. If the request
--- was unsuccessful returns `nil`.
--- @field request_sync fun(method: string, params: table?, timeout_ms: integer?, bufnr: integer): {err: lsp.ResponseError|nil, result:any}|nil, string|nil err # a dictionary, where
---
--- Sends a notification to an LSP server.
--- Returns: a boolean to indicate if the notification was successful. If
--- it is false, then it will always be false (the client has shutdown).
--- @field notify fun(method: string, params: table?): boolean
---
--- Cancels a request with a given request id.
--- Returns: same as `notify()`.
--- @field cancel_request fun(id: integer): boolean
---
--- Stops a client, optionally with force.
--- By default, it will just ask the server to shutdown without force.
--- If you request to stop a client which has previously been requested to
--- shutdown, it will automatically escalate and force shutdown.
--- @field stop fun(force?: boolean)
---
--- Runs the on_attach function from the client's config if it was defined.
--- Useful for buffer-local setup.
--- @field on_attach fun(bufnr: integer)
---
--- @field private _before_init_cb? vim.lsp.client.before_init_cb
--- @field private _on_attach_cbs vim.lsp.client.on_attach_cb[]
--- @field private _on_init_cbs vim.lsp.client.on_init_cb[]
--- @field private _on_exit_cbs vim.lsp.client.on_exit_cb[]
--- @field private _on_error_cb? fun(code: integer, err: string)
---
--- Checks if a client supports a given method.
--- Always returns true for unknown off-spec methods.
--- {opts} is a optional `{bufnr?: integer}` table.
--- Some language server capabilities can be file specific.
--- @field supports_method fun(method: string, opts?: {bufnr: integer?}): boolean
---
--- Checks whether a client is stopped.
--- Returns: true if the client is fully stopped.
--- @field is_stopped fun(): boolean
