###
backendFake - test back-end data for tests or debug UI
# https://docs.angularjs.org/api/ngMockE2E/service/$httpBackend
###
define [
    'cs!backendFake/index' ##NOTE: must used module contain 'ngMock'

], (module)->
    module.run ['$httpBackend', 'baseUrl', ($httpBackend, baseUrl)->
        ###
        #NOTE: fake demo data
        ###
        fakeDataArr = [
            "blockId": 4
            "taskId": 10
            "name": "Go through merchants of iOS"
            "taskType": "merchantSellCategoryCheck"
            "priority": 50
            "points": 100
            "assignmentsNeed": 1
            "assignmentsCount": 0
            "creationDate": "2014-08-04T10:45:15.79"
            "state": "available"
            "parameters": null
            "assignment": null
        ]
        ###
        when(method, url, [data], [headers])
        Creates a new backend definition.
        ###
        ###
        whenGET(url, [headers])
        Creates a new backend definition for GET requests.
        ###
        $httpBackend.whenGET(baseUrl + '/test').respond(->
            [200, fakeDataArr, {}])
        ###
        whenDELETE(url, [headers])
        Creates a new backend definition for DELETE requests.
        ###
        $httpBackend.whenDELETE(baseUrl + '/test/1').respond(->
            [201, {}, {}])
        ###
        whenPOST(url, [data], [headers])
        Creates a new backend definition for POST requests.
        ###
        $httpBackend.whenPOST(baseUrl + '/test').respond(
            (method, url, data)->
                newData = angular.fromJson(data)
                fakeDataArr.push(newData)
                return [200, fakeDataArr, {'X-Prism-Total-Items-Count': fakeDataArr.length}]
        )
        ###
        whenPUT(url, [data], [headers])
        Creates a new backend definition for PUT requests
        ###
        $httpBackend.whenPUT(baseUrl + '/tasks/1').respond(
            (method, url, data)->
                return [200, data, {}]
        )
    ]