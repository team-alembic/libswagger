defmodule SwaggerParserTests do
  use ExUnit.Case, async: true

  alias Swagger.Schema
  alias Swagger.Schema.{Endpoint, Operation, Parameter, Security}

  @keystore_example Path.join([__DIR__, "schemas", "keystore_example.yaml"])
  @petstore_example Path.join([__DIR__, "schemas", "pet_store.yaml"])

  test "can parse valid swagger spec" do
    {:ok, schema} = Swagger.parse_file(@keystore_example)

    assert %Schema{
             info: %{"title" => "Key-Value Store", "version" => "0.2"},
             host: "kv-service:8080",
             schemes: ["http", "https"],
             consumes: ["application/json"],
             produces: ["application/json"],
             paths: %{
               "/solution/{solution_id}" => %Endpoint{
                 operations: %{
                   get: %Operation{
                     id: "info",
                     responses: %{200 => _}
                   }
                 },
                 parameters: %{
                   "solution_id" => %Parameter.PathParam{
                     required?: true,
                     spec: %{:type => :string, :pattern => "^[a-zA-Z0-9]+$"}
                   }
                 }
               }
             }
           } = schema
  end

  test "can parse petstore spec" do
    {:ok, schema} = Swagger.parse_file(@petstore_example)

    assert schema == %Schema{
             base_path: "/v1",
             consumes: ["application/json"],
             host: "petstore.swagger.io",
             info: %{
               "license" => %{"name" => "MIT"},
               "title" => "Swagger Petstore",
               "version" => "1.0.0"
             },
             paths: %{
               "/pets" => %Endpoint{
                 name: "/pets",
                 operations: %{
                   get: %Operation{
                     consumes: [],
                     deprecated?: false,
                     description: "No description",
                     id: "listPets",
                     name: "get",
                     parameters: %{
                       "limit" => %Parameter.QueryParam{
                         allow_empty?: nil,
                         description: "How many items to return at one time (max 100)",
                         name: "limit",
                         properties: %{},
                         required?: false,
                         spec: %Parameter.Primitive{
                           collection_format: :csv,
                           default: nil,
                           enum: nil,
                           exclusive_maximum?: nil,
                           exclusive_minimum?: nil,
                           format: "int32",
                           items: [],
                           max_items: nil,
                           max_length: nil,
                           maximum: nil,
                           min_items: nil,
                           min_length: nil,
                           minimum: nil,
                           multiple_of: nil,
                           pattern: nil,
                           type: :integer,
                           unique_items?: false
                         }
                       }
                     },
                     produces: [],
                     properties: %{},
                     responses: %{
                       200 => %{
                         "additionalItems" => true,
                         "items" => %{
                           "description" => "A pet that we sell in the pet store",
                           "properties" => %{
                             "id" => %{
                               "format" => "int64",
                               "type" => "integer"
                             },
                             "name" => %{"type" => "string"},
                             "status" => %{"type" => "string"},
                             "tag" => %{"type" => "string"}
                           },
                           "required" => ["id", "name"]
                         },
                         "type" => "array"
                       },
                       :default => %{
                         "properties" => %{
                           "code" => %{
                             "format" => "int32",
                             "type" => "integer"
                           },
                           "message" => %{"type" => "string"}
                         },
                         "required" => ["code", "message"]
                       }
                     },
                     schemes: [],
                     security: [],
                     summary: "List all pets",
                     tags: ["pets"]
                   },
                   post: %Operation{
                     consumes: ["application/json", "application/xml"],
                     deprecated?: false,
                     description: "",
                     id: "addPet",
                     name: "post",
                     parameters: %{
                       "body" => %Parameter.BodyParam{
                         description: "Pet object that needs to be added to the store",
                         name: "body",
                         properties: %{},
                         required?: true,
                         schema: %{
                           "description" => "A pet that we sell in the pet store",
                           "properties" => %{
                             "id" => %{
                               "format" => "int64",
                               "type" => "integer"
                             },
                             "name" => %{"type" => "string"},
                             "status" => %{"type" => "string"},
                             "tag" => %{"type" => "string"}
                           },
                           "required" => ["id", "name"]
                         }
                       }
                     },
                     produces: ["application/xml", "application/json"],
                     properties: %{},
                     responses: %{
                       200 => %{
                         "description" => "A pet that we sell in the pet store",
                         "properties" => %{
                           "id" => %{"format" => "int64", "type" => "integer"},
                           "name" => %{"type" => "string"},
                           "status" => %{"type" => "string"},
                           "tag" => %{"type" => "string"}
                         },
                         "required" => ["id", "name"]
                       },
                       405 => nil
                     },
                     schemes: [],
                     security: [{"petstore_auth", ["write:pets", "read:pets"]}],
                     summary: "Add a new pet to the store",
                     tags: ["pet"]
                   }
                 },
                 parameters: %{},
                 properties: %{},
                 route_pattern: ~r/\/pets/
               },
               "/pets/{petId}" => %Endpoint{
                 name: "/pets/{petId}",
                 operations: %{
                   get: %Operation{
                     consumes: [],
                     deprecated?: false,
                     description: "No description",
                     id: "showPetById",
                     name: "get",
                     parameters: %{
                       "petId" => %Parameter.PathParam{
                         description: "The id of the pet to retrieve",
                         name: "petId",
                         properties: %{},
                         required?: true,
                         spec: %Parameter.Primitive{
                           collection_format: :csv,
                           default: nil,
                           enum: nil,
                           exclusive_maximum?: false,
                           exclusive_minimum?: false,
                           format: nil,
                           items: [],
                           max_items: nil,
                           max_length: nil,
                           maximum: nil,
                           min_items: nil,
                           min_length: nil,
                           minimum: nil,
                           multiple_of: nil,
                           pattern: nil,
                           type: :string,
                           unique_items?: false
                         }
                       }
                     },
                     produces: [],
                     properties: %{},
                     responses: %{
                       200 => %{
                         "description" => "A pet that we sell in the pet store",
                         "properties" => %{
                           "id" => %{"format" => "int64", "type" => "integer"},
                           "name" => %{"type" => "string"},
                           "status" => %{"type" => "string"},
                           "tag" => %{"type" => "string"}
                         },
                         "required" => ["id", "name"]
                       },
                       :default => %{
                         "properties" => %{
                           "code" => %{
                             "format" => "int32",
                             "type" => "integer"
                           },
                           "message" => %{"type" => "string"}
                         },
                         "required" => ["code", "message"]
                       }
                     },
                     schemes: [],
                     security: [],
                     summary: "Info for a specific pet",
                     tags: ["pets"]
                   }
                 },
                 parameters: %{},
                 properties: %{},
                 route_pattern: ~r/\/pets\/{petId}/
               }
             },
             produces: ["application/json"],
             properties: %{},
             schemes: ["http"],
             security: [],
             security_definitions: %{
               "api_key" => %Security.ApiKey{
                 description: nil,
                 id: "api_key",
                 in: :header,
                 name: "api_key",
                 properties: %{}
               },
               "petstore_auth" => %Security.OAuth2Implicit{
                 authorization_url: "http://petstore.swagger.io/oauth/dialog",
                 description: nil,
                 id: "petstore_auth",
                 properties: %{},
                 scopes: %{
                   "read:pets" => "read your pets",
                   "write:pets" => "modify pets in your account"
                 }
               }
             }
           }
  end
end
