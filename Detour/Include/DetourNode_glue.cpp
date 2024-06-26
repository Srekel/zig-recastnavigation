// auto generated by c2z
#include <new>
#include "DetourNode.h"

extern "C" const void* _1_DT_NULL_IDX_ = (void*)& ::DT_NULL_IDX;
extern "C" const void* _1_DT_NODE_PARENT_BITS_ = (void*)& ::DT_NODE_PARENT_BITS;
extern "C" const void* _1_DT_NODE_STATE_BITS_ = (void*)& ::DT_NODE_STATE_BITS;
extern "C" const void* _1_DT_MAX_STATES_PER_NODE_ = (void*)& ::DT_MAX_STATES_PER_NODE;
extern "C" void _1_dtNodePool_init_(::dtNodePool* self, int maxNodes, int hashSize) { new (self) ::dtNodePool(maxNodes, hashSize); }
extern "C" void _1_dtNodePool_deinit_(::dtNodePool *self) { self->~dtNodePool(); }
extern "C" void _1_dtNodePool_clear_(::dtNodePool* self) { self->clear(); }
extern "C" dtNode * _1_dtNodePool_getNode_(::dtNodePool* self, dtPolyRef id, unsigned char state) { return self->getNode(id, state); }
extern "C" dtNode * _1_dtNodePool_findNode_(::dtNodePool* self, dtPolyRef id, unsigned char state) { return self->findNode(id, state); }
extern "C" unsigned int _1_dtNodePool_findNodes_(::dtNodePool* self, dtPolyRef id, dtNode ** nodes, const int maxNodes) { return self->findNodes(id, nodes, maxNodes); }
extern "C" void _1_dtNodeQueue_init_(::dtNodeQueue* self, int n) { new (self) ::dtNodeQueue(n); }
extern "C" void _1_dtNodeQueue_deinit_(::dtNodeQueue *self) { self->~dtNodeQueue(); }
